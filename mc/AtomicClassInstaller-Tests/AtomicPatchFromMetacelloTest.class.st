Class {
	#name : #AtomicPatchFromMetacelloTest,
	#superclass : #TestCase,
	#instVars : [
		'baselineLoader',
		'atomicPatch'
	],
	#category : 'AtomicClassInstaller-Tests-Metacello'
}

{ #category : #'as yet unclassified' }
AtomicPatchFromMetacelloTest >> checkTokyoDB [
	| testClasses suite result |
	
	"I will assert that the TokyoDB library is corrected loaded, by running its tests"
	
	self assert: (Smalltalk environment hasClassNamed: #TokyoLibrary).
	self assert: (Smalltalk environment hasClassNamed: #TokyoObject).
	self
		assert:
			((Smalltalk environment at: #TokyoLibrary) methodDict
				includesKey: #unixModuleName).

	"Now I run the tests of TokyoDB to see if everything is ok"
	suite := TestSuite new.
	testClasses := (RPackage organizer packageNamed: 'TokyoDB')
		definedClasses
		select: [ :e | (e includesBehavior: TestCase) and: [ e isAbstract not ] ].
	testClasses do: [ :e | e addToSuiteFromSelectors: suite ].
	result := suite run.
	self assert: result errors size equals: 0.
	self assert: result failures size equals: 0.
	
	" Force the collection of the handle of the database"
	Smalltalk garbageCollectMost.

]

{ #category : #'as yet unclassified' }
AtomicPatchFromMetacelloTest >> setUp [
	super setUp.
	baselineLoader := AtomicMetacelloBaselineLoader baseline: 'TokyoDB' repository: 'filetree://tokyodb/mc'.
	
	AtomicClassInstaller reset.
	AtomicClassInstaller autocommit: false.
]

{ #category : #'as yet unclassified' }
AtomicPatchFromMetacelloTest >> tearDown [
	baselineLoader baseline unload.
	baselineLoader metacello unregister.

	(RPackageOrganizer default packageNamed: 'TokyoDB-Tests' ifAbsent:[nil]) ifNotNil:[ :pck |
		pck classes do:#removeFromSystem.
		RPackageOrganizer default unregisterPackage: pck
	].

	(MCWorkingCopy forPackage: (MCPackage named: 'TokyoDB-Tests')) unload .


	(RPackageOrganizer default packageNamed: 'TokyoDB' ifAbsent:[nil]) ifNotNil:[ :pck |
		pck classes do:#removeFromSystem.
		RPackageOrganizer default unregisterPackage: pck
	].

	(MCWorkingCopy forPackage: (MCPackage named: 'TokyoDB')) unload .

	AtomicClassInstaller autocommit: true.
	super tearDown
]

{ #category : #'as yet unclassified' }
AtomicPatchFromMetacelloTest >> testDetectingModyfiedClassesInTokyoDB [
	| mcPatch modifiedClasses |
	mcPatch := baselineLoader mcPatch.
	atomicPatch := baselineLoader atomicPatch.
	modifiedClasses := atomicPatch modifiedClasses.
	self assertCollection: modifiedClasses equals: #() asSet
]

{ #category : #tests }
AtomicPatchFromMetacelloTest >> testDetectingModyfiedMethodsInTokyoDB [
	| mcPatch modifiedMethods |
	mcPatch := baselineLoader mcPatch.
	atomicPatch := baselineLoader atomicPatch.
	modifiedMethods := atomicPatch modifiedMethods.
	
	self assert: modifiedMethods size equals: 105.
	self assert: (modifiedMethods includes: #(TokyoLibrary unixModuleName)).
	self assert: (modifiedMethods includes: #('TokyoObject class' object:size:)).
]

{ #category : #'as yet unclassified' }
AtomicPatchFromMetacelloTest >> testDetectingNewClassesInTokyoDB [
	| mcPatch newClasses |
	mcPatch := baselineLoader mcPatch.
	atomicPatch := baselineLoader atomicPatch.
	newClasses := atomicPatch newClasses.

	self
		assertCollection: newClasses
		equals: #(#TokyoConstants #TokyoDatabaseTest #TokyoHashDatabase #TokyoLibrary #TokyoTestResource #TokyoDatabase #TokyoHashConstants #TokyoHashDatabaseTest #TokyoObject) asSet
]

{ #category : #'as yet unclassified' }
AtomicPatchFromMetacelloTest >> testDetectingRemovedClassesInTokyoDB [
	| mcPatch removedClasses |
	mcPatch := baselineLoader mcPatch.
	atomicPatch := baselineLoader atomicPatch.
	removedClasses := atomicPatch removedClasses.

	self
		assertCollection: removedClasses
		equals: #() asSet
]

{ #category : #'as yet unclassified' }
AtomicPatchFromMetacelloTest >> testLoadingInverseOperationsFromMCPatch [
	| mcPatch inverseMCPatch |
	mcPatch := baselineLoader mcPatch.
	inverseMCPatch := MCPatch operations: ( mcPatch operations collect:#inverse ).
	atomicPatch := baselineLoader atomicPatch.

]

{ #category : #'as yet unclassified' }
AtomicPatchFromMetacelloTest >> testLoadingOperationsFromMCPatch [
	| mcPatch |
	mcPatch := baselineLoader mcPatch.
	atomicPatch := baselineLoader atomicPatch.

]

{ #category : #'as yet unclassified' }
AtomicPatchFromMetacelloTest >> testLoadingTokyoDBManually [
	| mcPatch |
	mcPatch := baselineLoader mcPatch.
	atomicPatch := baselineLoader atomicPatch.
	atomicPatch applyAll.

	self deny: (Smalltalk environment hasClassNamed: #TokyoLibrary).
	self deny: (Smalltalk environment hasClassNamed: #TokyoObject).

	AtomicClassInstaller commit.
	baselineLoader fixMonticelloPackage.

	self checkTokyoDB
]

{ #category : #'as yet unclassified' }
AtomicPatchFromMetacelloTest >> testLoadingTokyoDBWithLoader [
	self deny: (Smalltalk environment hasClassNamed: #TokyoLibrary).
	self deny: (Smalltalk environment hasClassNamed: #TokyoObject).
	baselineLoader loadPatch.
	self checkTokyoDB.

]
