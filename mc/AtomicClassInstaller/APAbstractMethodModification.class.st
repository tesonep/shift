Class {
	#name : #APAbstractMethodModification,
	#superclass : #APAbstractPatchOperation,
	#instVars : [
		'isMeta',
		'source',
		'category',
		'selector',
		'modifiedClassName',
		'timeStamp'
	],
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #'instance creation' }
APAbstractMethodModification class >> fromMCDefinition: mc [
	^	self basicNew
		isMeta: mc classIsMeta;
		source: mc source; 
		category: mc category;
		selector: mc selector;
		modifiedClassName: mc className;
		timeStamp: mc timeStamp;
		initialize;
		yourself
]

{ #category : #'instance creation' }
APAbstractMethodModification class >> fromSource: source selector: selector onClassNamed: aClassName [
	^	self basicNew
		isMeta: false;
		source: source; 
		category: #Unclassified;
		selector: selector;
		modifiedClassName: aClassName;
		timeStamp: nil;
		initialize;
		yourself
]

{ #category : #'as yet unclassified' }
APAbstractMethodModification >> actualClass [
	| cls |
	cls := AtomicClassInstaller uniqueInstance classAt: modifiedClassName.
	isMeta
		ifTrue: [ cls := cls class ].
	^ cls
]

{ #category : #accessing }
APAbstractMethodModification >> category [
	^ category
]

{ #category : #accessing }
APAbstractMethodModification >> category: anObject [
	category := anObject
]

{ #category : #accessing }
APAbstractMethodModification >> isMeta [
	^ isMeta
]

{ #category : #accessing }
APAbstractMethodModification >> isMeta: anObject [
	isMeta := anObject
]

{ #category : #accessing }
APAbstractMethodModification >> modifiedClassName [
	isMeta ifTrue:[
		^ modifiedClassName , ' class'
	].
	^ modifiedClassName
]

{ #category : #accessing }
APAbstractMethodModification >> modifiedClassName: anObject [
	modifiedClassName := anObject
]

{ #category : #accessing }
APAbstractMethodModification >> modifiedMethods [
	^{{self modifiedClassName. selector}}.
]

{ #category : #accessing }
APAbstractMethodModification >> selector [
	^ selector
]

{ #category : #accessing }
APAbstractMethodModification >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
APAbstractMethodModification >> source [
	^ source
]

{ #category : #accessing }
APAbstractMethodModification >> source: anObject [
	source := anObject
]

{ #category : #accessing }
APAbstractMethodModification >> timeStamp [
	^ timeStamp
]

{ #category : #accessing }
APAbstractMethodModification >> timeStamp: anObject [
	timeStamp := anObject
]
