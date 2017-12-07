Class {
	#name : #AtomicPatch,
	#superclass : #Object,
	#instVars : [
		'operations',
		'transformations',
		'preScript',
		'postScript'
	],
	#category : 'AtomicClassInstaller-AtomicPatch'
}

{ #category : #'as yet unclassified' }
AtomicPatch class >> fromMCPatch: mcPatch [
	^ AtomicMonticelloPatchConversor convertFromMCPatch: mcPatch.
]

{ #category : #'as yet unclassified' }
AtomicPatch class >> fromMCVersions: mcVersions [
	^ AtomicMonticelloPatchConversor convertFromMCVersions: mcVersions.
]

{ #category : #operations }
AtomicPatch >> addAll: aCollection [ 
	operations addAll: aCollection.
]

{ #category : #operations }
AtomicPatch >> addOperation: anOperation [ 
	operations add:anOperation.
]

{ #category : #operations }
AtomicPatch >> applyAll [
	self runPreScript.
	operations do:#apply.
	operations do:#postActionApply.
	self runPostScript.
]

{ #category : #'as yet unclassified' }
AtomicPatch >> asSTON [
	^ STON toStringPretty: self.
]

{ #category : #operations }
AtomicPatch >> initialize [
	super initialize.
	operations := OrderedCollection new.
	transformations := Dictionary new.
]

{ #category : #quering }
AtomicPatch >> modifiedClasses [
	^ (operations flatCollect: #modifiedClasses) asSet.
]

{ #category : #quering }
AtomicPatch >> modifiedMethods [
	^ (operations flatCollect: #modifiedMethods) asSet.
]

{ #category : #quering }
AtomicPatch >> newClasses [
	^ (operations flatCollect: #newClasses) asSet.
]

{ #category : #operations }
AtomicPatch >> numberOfOperations [ 
	^ operations size.
]

{ #category : #migrating }
AtomicPatch >> objectMigratorFor: oldClass to: newClass [
	^ transformations
		at: newClass name
		ifPresent: [ :v | 
			v isString
				ifTrue: [ ACIBlockObjectMigrator new blockCode: v ]
				ifFalse: [ v ] ]
		ifAbsent: [ ACIDefaultObjectMigrator new ]
]

{ #category : #accessing }
AtomicPatch >> operations [
	^ operations
]

{ #category : #accessing }
AtomicPatch >> operations: anObject [
	operations := anObject
]

{ #category : #accessing }
AtomicPatch >> postScript [
	^ postScript
]

{ #category : #accessing }
AtomicPatch >> postScript: anObject [
	postScript := anObject
]

{ #category : #accessing }
AtomicPatch >> preScript [
	^ preScript
]

{ #category : #accessing }
AtomicPatch >> preScript: anObject [
	preScript := anObject
]

{ #category : #quering }
AtomicPatch >> removedClasses [
	^ (operations flatCollect: #removedClasses) asSet.
]

{ #category : #accessing }
AtomicPatch >> runPostScript [
	^self runScript: postScript.
]

{ #category : #accessing }
AtomicPatch >> runPreScript [
	^self runScript: preScript.
]

{ #category : #accessing }
AtomicPatch >> runScript: aScriptText [
	aScriptText ifNil: [ ^ self ].
	^self class compiler evaluate: aScriptText.

]

{ #category : #accessing }
AtomicPatch >> transformations [
	^ transformations
]

{ #category : #accessing }
AtomicPatch >> transformations: anObject [
	transformations := anObject
]

{ #category : #migrating }
AtomicPatch >> whenMigrating: aClassName use: migrator [
	" The migrator parameter can be a block, that it should be clean, a String representing a block or an object that implements the interface.
	  If the migrator is an object it should be able to translate to STON if the patch is a remote patch.
	"
	| code |
	code := migrator isClosure
		ifTrue: [ 
			self assert: migrator isClean description: 'If the parameter is a block it should be clean'.
			migrator asString ]
		ifFalse: [ migrator ].
	transformations at: aClassName asSymbol put: code
]
