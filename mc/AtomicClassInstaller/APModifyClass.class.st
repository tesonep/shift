Class {
	#name : #APModifyClass,
	#superclass : #APAbstractClassModification,
	#instVars : [
		'originalClassDefinition'
	],
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #'as yet unclassified' }
APModifyClass class >> fromMCDefinition: mcDefinition [
	^ (self basicFromMCDefinition: mcDefinition)
		originalClassDefinition: (APCreateClass fromMCDefinition: mcDefinition actualClass asClassDefinition);
		initialize;
		yourself
]

{ #category : #'as yet unclassified' }
APModifyClass class >> fromMCDefinition: mcDefinition baseDefinition: mcBaseDefinition [
	^ (self basicFromMCDefinition: mcDefinition)
		originalClassDefinition: (APCreateClass fromMCDefinition: mcBaseDefinition);
		initialize;
		yourself
]

{ #category : #accessing }
APModifyClass >> modifiedClasses [
	^ { definedClassName }
]

{ #category : #accessing }
APModifyClass >> originalClassDefinition [
	^ originalClassDefinition
]

{ #category : #accessing }
APModifyClass >> originalClassDefinition: anObject [
	originalClassDefinition := anObject
]
