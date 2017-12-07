Class {
	#name : #APAddMethod,
	#superclass : #APAbstractMethodModification,
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #'as yet unclassified' }
APAddMethod >> apply [
	self actualClass
		compile: source
		classified: category
		withStamp: timeStamp
		notifying: nil
]

{ #category : #accessing }
APAddMethod >> postActionApply [
	(isMeta and:[ selector = #initialize ]) ifTrue:[
		self actualClass theNonMetaClass initialize.
	]
]
