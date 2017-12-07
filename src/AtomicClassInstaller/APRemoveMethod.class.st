Class {
	#name : #APRemoveMethod,
	#superclass : #APAbstractMethodModification,
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #'as yet unclassified' }
APRemoveMethod >> apply [
	self actualClass removeSelector: selector

]
