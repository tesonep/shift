Class {
	#name : #ACIMockProcess,
	#superclass : #Object,
	#instVars : [
		'semaphore',
		'returnValue'
	],
	#category : 'AtomicClassInstaller-Tests-Process'
}

{ #category : #'as yet unclassified' }
ACIMockProcess >> doYourMagic [
	semaphore wait.
	^ 42
]

{ #category : #accessing }
ACIMockProcess >> returnValue [
	^ returnValue
]

{ #category : #accessing }
ACIMockProcess >> returnValue: anObject [
	returnValue := anObject
]

{ #category : #'as yet unclassified' }
ACIMockProcess >> run [
	returnValue := self doYourMagic.
	self assert: (returnValue = 42)
]

{ #category : #'as yet unclassified' }
ACIMockProcess >> runWithoutMagic [
	semaphore wait.
]

{ #category : #accessing }
ACIMockProcess >> semaphore [
	^ semaphore
]

{ #category : #accessing }
ACIMockProcess >> semaphore: anObject [
	semaphore := anObject
]
