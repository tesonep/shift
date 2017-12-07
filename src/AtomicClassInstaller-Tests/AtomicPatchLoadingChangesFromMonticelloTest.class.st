Class {
	#name : #AtomicPatchLoadingChangesFromMonticelloTest,
	#superclass : #TestCase,
	#instVars : [
		'mcLoader',
		'atomicPatch',
		'mcRepo'
	],
	#category : 'AtomicClassInstaller-Tests-Metacello'
}

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> aciSubclass [
	^ self environment at:#ACISubclass.
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> aciUser [
	^ self environment at:#ACIUser.
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> environment [
	^ Smalltalk globals.
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> repoDirectory [
	" It changes the path of the testCode repository, depending if it is in development environment or in Travis-CI"
	^ Smalltalk os environment
		at: 'TRAVIS'
		ifPresent: [ 'testCode-Repo' ]
		ifAbsent: [ '/Users/admin/dev/Pharo/shift/pharo-local/iceberg/tesonep/pharo-AtomicClassInstaller/testCode-Repo' ]
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> setUp [
	self tearDown.
	mcRepo := MCDirectoryRepository new
		directory: self repoDirectory asFileReference;
		yourself.
		
	MCWorkingCopy announcer suspendAllWhile: [ (mcRepo versionFrom: self sourceVersion) load ].

]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> sourceVersion [
	^ 'AtomicClassInstaller-Tests-Code-PabloTesone.4'
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> targetVersion [
	^ 'AtomicClassInstaller-Tests-Code-PabloTesone.5'
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> tearDown [
	MCWorkingCopy announcer
		suspendAllWhile:
			[ (MCWorkingCopy forPackage: (MCPackage named: 'AtomicClassInstaller-Tests-Code')) unload ].

	(RPackageOrganizer default
		packageNamed: #'AtomicClassInstaller-Tests-Code'
		ifAbsent: [ nil ]) ifNotNil: [ :p | RPackageOrganizer default unregisterPackage: p ].

	(RPackageOrganizer default packageNamed: 'AtomicClassInstaller-Tests')
		classTagNamed: #Code
		ifPresent:
			[ :tag | 
			tag classes do: [ :e | tag removeClass: e ].
			tag removeFromPackage ].
	
	AtomicClassInstaller autocommit: true.
	super tearDown
]

{ #category : #tests }
AtomicPatchLoadingChangesFromMonticelloTest >> testCreatePatch [
	| mcVersion patch firstOperation |
	mcVersion := mcRepo versionFrom: self targetVersion.
	patch := AtomicPatch fromMCVersions: {mcVersion}.

	self assert: patch operations size equals: 16.
	firstOperation := patch operations at: 1.

	self assert: firstOperation class equals: APModifyClass.
	self assert: firstOperation definedClassName equals: #ACISubclass.
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> testLoadPatch [
	| mcVersion patch loader |

	self assert: self aciUser allSlots size equals: 3.
	self deny: (self aciUser allSlots anySatisfy:[:s | s name = #fullname]). 

	mcVersion := mcRepo versionFrom: self targetVersion.
	patch := AtomicPatch fromMCVersions: {mcVersion}.
	loader := AtomicLoader new.
	loader loadPatch: patch.
	
	self assert: self aciUser allSlots size equals: 4.
	self assert: (self aciUser allSlots anySatisfy:[:s | s name = #fullname]). 	
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> testLoadPatchWithObjectsAlive [
	| mcVersion patch loader usr1 usr2 |
	usr1 := self aciUser new.
	usr1 firstname: 'Pepe'.
	usr1 lastname: 'Argento'.

	usr2 := self aciUser new.
	usr2 firstname: 'Coqui'.
	usr2 lastname: 'Argento'.

	self assert: usr1 firstname equals: 'Pepe'.
	self assert: usr1 lastname equals: 'Argento'.
	self assert: usr1 fullName equals: 'Pepe Argento'.
	self assert: usr2 fullName equals: 'Coqui Argento'.

	mcVersion := mcRepo versionFrom: self targetVersion.
	patch := AtomicPatch fromMCVersions: {mcVersion}.

	patch
		whenMigrating: #ACIUser
		use: [ :new :old :migrator | 
			migrator basicMigrateInstance: new from: old.
			new buildFullname ].

	loader := AtomicLoader new.
	loader loadPatch: patch.

	self assert: usr1 firstname equals: 'Pepe'.
	self assert: usr1 lastname equals: 'Argento'.	
	self assert: usr1 fullName equals: 'Pepe Argento'.
	self assert: usr2 fullName equals: 'Coqui Argento'
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> testLoadPatchWithProcessAlive [
	| mcVersion patch loader users process errors |
	users := OrderedCollection new.
	errors := 0.

	1 to: 50 do: [ :idx | 
		| u f l |
		u := self aciUser new.
		f := String loremIpsum: 7 atRandom + 3.
		l := String loremIpsum: 7 atRandom + 3.
		u firstname: f.
		u lastname: l.
		users
			add:
				{u.
				(f , ' ' , l)} ].

	process := [ [ true ]
		whileTrue: [ 
			users
				do: [ :pair | | nf nl |
					pair first fullName = pair second
						ifFalse: [ errors := errors + 1 ].
					nf := String loremIpsum: 7 atRandom + 3.
					nl := String loremIpsum: 7 atRandom + 3.
					pair first firstname: nf.
					pair first lastname: nl.
					pair at:2 put: (nf , ' ' , nl).
					].
			Processor yield 
		] ] fork.

	mcVersion := mcRepo versionFrom: self targetVersion.
	patch := AtomicPatch fromMCVersions: {mcVersion}.

	patch
		whenMigrating: #ACIUser
		use: [ :new :old :migrator | 
			migrator basicMigrateInstance: new from: old.
			new buildFullname ].

	loader := AtomicLoader new.
	loader loadPatch: patch.

	(Delay forSeconds: 3) wait.
	process terminate.

	self assert: errors equals: 0
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> testPullUpVariable [
	| mcVersion patch loader objects |
	
	objects := OrderedCollection new.
	
	1 to: 100 do: [ :index | |o|
		o := self aciSubclass new.
		o anAtribute: 100 atRandom.
		o anotherAtribute: 100 atRandom.
		objects add:{o. o someMessage}.
	].

	mcVersion := mcRepo versionFrom: self targetVersion.
	patch := AtomicPatch fromMCVersions: {mcVersion}.
	loader := AtomicLoader new.

	loader loadPatch: patch.
	
	objects do:[:e | self assert: e second equals: e first someMessage].
]

{ #category : #'as yet unclassified' }
AtomicPatchLoadingChangesFromMonticelloTest >> testingTestInfra [
	| usr |
	usr := self aciUser new.
	usr firstname: 'Pablo'.
	usr lastname: 'Tesone'.
	self assert: usr fullName equals: 'Pablo Tesone'.
]
