Class {
	#name : #APAbstractPatchOperation,
	#superclass : #Object,
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #'as yet unclassified' }
APAbstractPatchOperation >> apply [
	self subclassResponsibility.
]

{ #category : #'as yet unclassified' }
APAbstractPatchOperation >> installer [
	^ AtomicClassInstaller uniqueInstance 
]

{ #category : #'as yet unclassified' }
APAbstractPatchOperation >> modifiedClasses [
	^ #()
]

{ #category : #'as yet unclassified' }
APAbstractPatchOperation >> modifiedMethods [
	^#().
]

{ #category : #'as yet unclassified' }
APAbstractPatchOperation >> newClasses [
	^ #()
]

{ #category : #'as yet unclassified' }
APAbstractPatchOperation >> postActionApply [

]

{ #category : #'as yet unclassified' }
APAbstractPatchOperation >> removedClasses [
	^ #()
]
