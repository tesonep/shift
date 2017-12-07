Class {
	#name : #APCreateClass,
	#superclass : #APAbstractClassModification,
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #'as yet unclassified' }
APCreateClass >> newClasses [
	^ { definedClassName }
]
