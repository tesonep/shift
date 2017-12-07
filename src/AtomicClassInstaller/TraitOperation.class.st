Class {
	#name : #TraitOperation,
	#superclass : #AtomicClassInstallerOperation,
	#instVars : [
		'modifiedTrait',
		'modifiedClass'
	],
	#category : 'AtomicClassInstaller-Operations'
}

{ #category : #'instance creation' }
TraitOperation class >> for: anAtomicClassInstaller class: aClass trait: aTrait [ 
	| op |
	op := self basicNew.
	op modifiedClass: aClass.
	op modifiedTrait: aTrait.
	op installer: anAtomicClassInstaller.
	op initialize.
	
	anAtomicClassInstaller addOperation:op.
	
	^op.
]

{ #category : #accessing }
TraitOperation >> modifiedClass [
	^ modifiedClass
]

{ #category : #accessing }
TraitOperation >> modifiedClass: anObject [
	modifiedClass := anObject
]

{ #category : #accessing }
TraitOperation >> modifiedTrait [
	^ modifiedTrait
]

{ #category : #accessing }
TraitOperation >> modifiedTrait: anObject [
	modifiedTrait := anObject
]
