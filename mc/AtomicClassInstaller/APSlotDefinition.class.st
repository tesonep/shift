Class {
	#name : #APSlotDefinition,
	#superclass : #Object,
	#instVars : [
		'slotName',
		'type'
	],
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #'instance creation' }
APSlotDefinition class >> name: aName type: aType [
	^self new 
		slotName: aName;
		type: aType;
		yourself 
]

{ #category : #'instance creation' }
APSlotDefinition class >> newInstanceVariable: slotName [ 
	^ self basicNew
		slotName: slotName;
		type: #InstanceVariableSlot;
		initialize;
		yourself.
]

{ #category : #accessing }
APSlotDefinition >> slotName [
	^ slotName
]

{ #category : #accessing }
APSlotDefinition >> slotName: anObject [
	slotName := anObject
]

{ #category : #accessing }
APSlotDefinition >> type [
	^ type
]

{ #category : #accessing }
APSlotDefinition >> type: anObject [
	type := anObject
]
