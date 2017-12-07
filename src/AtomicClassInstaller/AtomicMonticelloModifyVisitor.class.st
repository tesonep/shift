Class {
	#name : #AtomicMonticelloModifyVisitor,
	#superclass : #AtomicMonticelloAbstractVisitor,
	#instVars : [
		'baseDefinition'
	],
	#category : 'AtomicClassInstaller-Monticello'
}

{ #category : #accessing }
AtomicMonticelloModifyVisitor >> baseDefinition [
	^ baseDefinition
]

{ #category : #accessing }
AtomicMonticelloModifyVisitor >> baseDefinition: anObject [
	baseDefinition := anObject
]

{ #category : #visitor }
AtomicMonticelloModifyVisitor >> visitClassDefinition: aDefinition [ 
	patch addOperation: (APModifyClass fromMCDefinition: aDefinition baseDefinition: baseDefinition)
]

{ #category : #visitor }
AtomicMonticelloModifyVisitor >> visitMetaclassDefinition: aDefinition [ 
	"Nothing to do, modifications handled with the instance side."
]

{ #category : #visitor }
AtomicMonticelloModifyVisitor >> visitMethodDefinition: targetDefinition [ 
	| operation |
	operation := APModifyMethod fromMCDefinition: targetDefinition.
	operation originalMethodDefinition: (APAddMethod fromMCDefinition: baseDefinition ).
	patch addOperation: operation.
]
