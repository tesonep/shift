Class {
	#name : #ACIMonticelloVersionBrowser,
	#superclass : #ACIAbstractBrowser,
	#instVars : [
		'selectedVersions',
		'selectedVersionsPresentation',
		'announcer'
	],
	#category : 'AtomicClassInstaller-UI'
}

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser class >> open [
	^ self new
		open
]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> addSelectedVersion: panel [
	| repo versionName |
	repo := panel entity first.
	versionName := panel selection.
	selectedVersions add: (repo versionFrom: versionName).
	self announcer announce: ACISelectedVersionsUpdate new.


]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> allPackagesFrom: aRepo [
	^ (aRepo packageDescriptionsFromReadableFileNames collect:#first) asSet asOrderedCollection 
]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> announcer [
	^ announcer ifNil:[ announcer := Announcer new]
]

{ #category : #actions }
ACIMonticelloVersionBrowser >> createPatch [
	| patch |
	patch := AtomicPatch fromMCVersions: selectedVersions .
	AtomicPatchBrowser openOn: patch.
]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> doBuildBrowser [
	browser := GLMTabulator new.
	browser
		row: [ :r | 
			r column: #repositories.
			r column: #packages.
			r column: #versions ].
	browser row:#selectedVersions.
	browser row:#actions size:30.
	
	browser transmit
		to:#actions;
		andShow: [ :builder | builder actionList act:[self createPatch] entitled:'Create Patch'].

	browser transmit
		to: #repositories;
		andShow: [ :builder | self repositoriesIn: builder ].

	browser transmit
		to: #selectedVersions;
		andShow: [:builder | self selectedVersionsIn: builder].
		
	browser transmit
		from: #repositories;
		to: #packages;
		andShow: [ :builder | self packagesIn: builder ].
		
	browser transmit
		from: #repositories;
		from: #packages;
		to: #versions;
		andShow: [ :builder | self versionsIn: builder ].
]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> initialize [
	super initialize.
	selectedVersions := Set new.
	
]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> packagesIn: builder [
	builder fastList
		enableFilter;
		title:'Packages';
		display:[:repo | self allPackagesFrom:repo ];
		icon:[ Smalltalk ui icons iconNamed:#package ]
		
]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> repositoriesIn: builder [
	builder fastList
		enableFilter;
		title:'Monticello Repositories';
		format: #description;
		icon:[ Smalltalk ui icons iconNamed:#monticelloPackage ]
		
]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> roots [
	^ MCRepositoryGroup default repositories
		asSortedCollection: [ :a :b | a description <= b description ]
]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> selectedVersionsIn: builder [
	builder fastList
		enableFilter;
		title: 'Selected Versions';
		display: [ selectedVersions asOrderedCollection ];
		format: [ :item | item info name ];
		icon: [ Smalltalk ui icons iconNamed: #monticelloPackage ];
		updateOn: ACISelectedVersionsUpdate from: self announcer.
]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> title [
	^ 'Create AtomicPatch from Monticello Versions'
]

{ #category : #'as yet unclassified' }
ACIMonticelloVersionBrowser >> versionsIn: builder [
	builder fastList
		enableFilter;
		title: 'Versions';
		act: [ :panel | self addSelectedVersion: panel ] icon: (Smalltalk ui icons iconNamed: #add) entitled: 'Add';
		display: [ :repo :package | repo allVersionNames select: [ :e | (e findString: package) = 1 ] ];
		icon: [ Smalltalk ui icons iconNamed: #monticelloPackage ]
]
