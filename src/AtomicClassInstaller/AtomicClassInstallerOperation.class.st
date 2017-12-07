Class {
	#name : #AtomicClassInstallerOperation,
	#superclass : #Object,
	#instVars : [
		'installer'
	],
	#category : 'AtomicClassInstaller-Operations'
}

{ #category : #accessing }
AtomicClassInstallerOperation >> assert: aValuable [
	AtomicClassInstaller isAssertActive ifTrue:[
		super assert:aValuable description: aValuable asString .	
	]
]

{ #category : #actions }
AtomicClassInstallerOperation >> impact [
	^ self subclassResponsibility.
]

{ #category : #accessing }
AtomicClassInstallerOperation >> installer [
	^ installer
]

{ #category : #accessing }
AtomicClassInstallerOperation >> installer: anObject [
	installer := anObject
]
