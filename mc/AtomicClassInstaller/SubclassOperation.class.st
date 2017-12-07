Class {
	#name : #SubclassOperation,
	#superclass : #AtomicClassInstallerOperation,
	#instVars : [
		'modifiedClass',
		'superclass'
	],
	#category : 'AtomicClassInstaller-Operations'
}

{ #category : #'as yet unclassified' }
SubclassOperation class >> for: installer class: class superclass: aSuperclass [ 
	| op |
	op := self basicNew
				installer: installer;
				modifiedClass: class;
				superclass: aSuperclass;
				initialize;
				yourself.
				
	installer addOperation: op.
	^op.
]

{ #category : #accessing }
SubclassOperation >> modifiedClass [
	^ modifiedClass
]

{ #category : #accessing }
SubclassOperation >> modifiedClass: anObject [
	modifiedClass := anObject
]

{ #category : #accessing }
SubclassOperation >> superclass [
	^ superclass
]

{ #category : #accessing }
SubclassOperation >> superclass: anObject [
	superclass := anObject
]
