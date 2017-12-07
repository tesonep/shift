Class {
	#name : #NewClassTest,
	#superclass : #AbstractAtomicInstallerTest,
	#category : 'AtomicClassInstaller-Tests'
}

{ #category : #'as yet unclassified' }
NewClassTest >> tearDown [
	self environment at:#NewClass ifPresent:[:x | x removeFromSystem].
	super tearDown.
]

{ #category : #'as yet unclassified' }
NewClassTest >> testCreationOfNewClass [
	| class |
	
	class := AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #NewClass;
				slots: #(#a #b);
				category: 'AtomicClassInstaller-Tests' ].
	
	self assert: (Smalltalk environment hasClassNamed: #NewClass) not.				
	self assert: class methods size equals: 0.
	self assert: (Object subclasses includes: class) not.
	
	self compile: 'aSimpleMethod
			^ a.
	' on: class.
	
	self assertNonAnnouncements.
	
	AtomicClassInstaller commit.
	
	self assert: (Object subclasses includes: class).
	self assert: (Smalltalk environment hasClassNamed: #NewClass).
	self assert: (Smalltalk environment at:#NewClass) category equals: 'AtomicClassInstaller-Tests'.
	self assert: ((Smalltalk globals organization classesInCategory:'AtomicClassInstaller-Tests') includes: (Smalltalk environment at:#NewClass))
]
