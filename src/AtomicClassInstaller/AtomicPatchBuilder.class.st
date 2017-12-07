Class {
	#name : #AtomicPatchBuilder,
	#superclass : #Object,
	#instVars : [
		'operations',
		'modifiedClasses',
		'instanceMigrators'
	],
	#category : 'AtomicClassInstaller-AtomicPatch'
}

{ #category : #operations }
AtomicPatchBuilder >> addOperation: anOperation [
	(operations includes: anOperation)
		ifFalse: [ operations add: anOperation ]
]

{ #category : #building }
AtomicPatchBuilder >> buildPatch [
	| patch |
	patch := AtomicPatch new
		addAll: operations;
		yourself.

	instanceMigrators
		keysAndValuesDo: [ :aClassName :migrator | patch whenMigrating: aClassName use: migrator ].

	^ patch
]

{ #category : #accessing }
AtomicPatchBuilder >> classModificationFromDefinition: aDefinition [
	| modifyClass |
	modifyClass := APModifyClass fromClassDefinition: aDefinition.
	^modifiedClasses at: modifyClass definedClassName ifAbsentPut:modifyClass.
]

{ #category : #accessing }
AtomicPatchBuilder >> classModificationFromRBClass: aRBClass [
	^ modifiedClasses
		at: aRBClass name
		ifAbsentPut: [ APModifyClass
				fromRBClass:
					(aRBClass isMeta
						ifTrue: [ aRBClass theNonMetaClass ]
						ifFalse: [ aRBClass ]) ]
]

{ #category : #initialization }
AtomicPatchBuilder >> initialize [
	operations := OrderedCollection new.
	modifiedClasses := Dictionary new.
	instanceMigrators := Dictionary new.
]

{ #category : #building }
AtomicPatchBuilder >> whenMigrating: aClassName use: migrator [
	instanceMigrators at: aClassName put: migrator
	
]
