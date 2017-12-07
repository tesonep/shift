Class {
	#name : #ACIContext,
	#superclass : #Object,
	#instVars : [
		'block'
	],
	#category : 'AtomicClassInstaller-Process'
}

{ #category : #accessing }
ACIContext >> block [
	^ block
]

{ #category : #accessing }
ACIContext >> block: anObject [
	block := anObject
]

{ #category : #'as yet unclassified' }
ACIContext >> doInTheMiddle [
	| r |
	r := thisContext pop.
	block value.
	^ r.
]
