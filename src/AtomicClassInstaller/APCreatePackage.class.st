Class {
	#name : #APCreatePackage,
	#superclass : #APAbstractPatchOperation,
	#instVars : [
		'package'
	],
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #public }
APCreatePackage >> apply [
	| organizer |
	organizer := self installer packageOrganizer.
	(organizer packages
		anySatisfy: [ :each | organizer category: package matches: each packageName ])
		ifFalse: [ organizer registerPackage: (RPackage named: package capitalized) ]
]

{ #category : #accessing }
APCreatePackage >> package [
	^ package
]

{ #category : #accessing }
APCreatePackage >> package: anObject [
	package := anObject
]
