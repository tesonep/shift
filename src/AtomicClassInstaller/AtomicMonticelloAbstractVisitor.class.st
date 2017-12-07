Class {
	#name : #AtomicMonticelloAbstractVisitor,
	#superclass : #Object,
	#instVars : [
		'patch'
	],
	#category : 'AtomicClassInstaller-Monticello'
}

{ #category : #accessing }
AtomicMonticelloAbstractVisitor >> patch [
	^ patch
]

{ #category : #accessing }
AtomicMonticelloAbstractVisitor >> patch: anObject [
	patch := anObject
]
