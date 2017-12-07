Class {
	#name : #APModifyMethod,
	#superclass : #APAbstractMethodModification,
	#instVars : [
		'originalMethodDefinition'
	],
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #accessing }
APModifyMethod >> originalMethodDefinition [
	^ originalMethodDefinition
]

{ #category : #accessing }
APModifyMethod >> originalMethodDefinition: anObject [
	originalMethodDefinition := anObject
]
