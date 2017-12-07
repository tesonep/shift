Class {
	#name : #APRemoveClass,
	#superclass : #APAbstractClassModification,
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #'as yet unclassified' }
APRemoveClass >> apply [
	^ self removedClasses do: [:e | AtomicClassInstaller removeClass: (self class environment at:e) ].
]

{ #category : #'as yet unclassified' }
APRemoveClass >> removedClasses [
	^ { definedClassName }
]
