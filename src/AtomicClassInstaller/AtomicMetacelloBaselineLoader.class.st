Class {
	#name : #AtomicMetacelloBaselineLoader,
	#superclass : #Object,
	#instVars : [
		'baselineName',
		'repository',
		'repositoryURI',
		'metacello',
		'baseline'
	],
	#category : 'AtomicClassInstaller-Loader'
}

{ #category : #'instance-creation' }
AtomicMetacelloBaselineLoader class >> baseline: aBaselineName repository: aRepositoryURI [
	^ self basicNew
			baselineName: aBaselineName;
			repositoryURI: aRepositoryURI;
			initialize;
			yourself.
]

{ #category : #'as yet unclassified' }
AtomicMetacelloBaselineLoader >> atomicPatch [
	^ AtomicMonticelloPatchConversor convertFromMCPatch: self mcPatch.

]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> baseline [
	^ baseline
]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> baselineName [
	^ baselineName
]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> baselineName: anObject [
	baselineName := anObject
]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> fixMonticelloPackage [
	self mcVersions do:[:e | 
		e adopt.
		e workingCopy repositoryGroup addRepository: repository.
	]
]

{ #category : #initialization }
AtomicMetacelloBaselineLoader >> initialize [
	super initialize.
	
	metacello := Metacello new
		baseline: self baselineName ;
		repository: repositoryURI;
		fetch;
		yourself.
		
	baseline := Smalltalk globals at: ('BaselineOf' , baselineName) asSymbol.
]

{ #category : #'as yet unclassified' }
AtomicMetacelloBaselineLoader >> loadPatch [
	| loader |
	loader := AtomicLoader new.
	loader loadPatch: self atomicPatch.
	self fixMonticelloPackage.
]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> mcPatch [
	^ MCPatch fromVersions: self mcVersions 
]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> mcVersions [
	| files |
	files := self packages collect: [ :e | e file , repository packageExtension ].
	^ (files collect: [ :e | repository versionNameFromFileName: e ])
							collect: [ :e | repository versionFrom: e ].

]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> metacello [
	^ metacello
]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> packages [
	^ self version allPackagesForSpecNamed:'default'.
]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> repository [
	^ repository
]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> repository: anObject [
	repository := anObject
]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> repositoryURI: aRepositoryURI [
	repositoryURI := aRepositoryURI.
	self repository: (MCRepository fromUrl: aRepositoryURI).
]

{ #category : #accessing }
AtomicMetacelloBaselineLoader >> version [
	^ baseline project lastVersion.
]
