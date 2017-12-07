Class {
	#name : #AbstractAtomicInstallerTest,
	#superclass : #TestCase,
	#instVars : [
		'receivedAnnouncements'
	],
	#category : 'AtomicClassInstaller-Tests'
}

{ #category : #running }
AbstractAtomicInstallerTest >> announcementReceived: ann [
	receivedAnnouncements add: ann.
	
]

{ #category : #running }
AbstractAtomicInstallerTest >> assertNonAnnouncements [
	self assertCollection: self receivedAnnouncements equals: #() asOrderedCollection.
]

{ #category : #'test class creation' }
AbstractAtomicInstallerTest >> buildClassWithClassVariable [
	Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: #ClassWithClassVariable;
				traitComposition: {};
				slots: #();
				classSlots: #(classVariable);
				category: 'AtomicClassInstaller-Tests' ].
			
	self classWithClassVariable class compile:'
		classVariable
			^classVariable.
	'.
	
	self classWithClassVariable class compile:'
		classVariable:aValue
			classVariable := aValue.
	'.
]

{ #category : #'test class creation' }
AbstractAtomicInstallerTest >> buildOldClass [
	Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: #OldClass;
				slots: #(#firstVariable #secondVariable);
				category: 'AtomicClassInstaller-Tests' ].
	self oldClass
		compile:
			'
		firstVariable
			^firstVariable.
	'.
	self oldClass
		compile:
			'
		firstVariable: aValue
			firstVariable := aValue.
	'.
	self oldClass
		compile:
			'
		secondVariable
			^secondVariable.
	'.
	self oldClass
		compile:
			'
		secondVariable: aValue
			secondVariable := aValue.
	'
]

{ #category : #'test class creation' }
AbstractAtomicInstallerTest >> buildOldComparableClass [
	Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: #OldComparableClass;
				traitComposition: TComparable;
				slots: #(#firstVariable);
				category: 'AtomicClassInstaller-Tests' ]
]

{ #category : #'test class creation' }
AbstractAtomicInstallerTest >> buildOtherClass [
	Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: #OtherClass;
				slots: #();
				category: 'AtomicClassInstaller-Tests' ]
]

{ #category : #'test class creation' }
AbstractAtomicInstallerTest >> buildOtherSubClass [
	Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: #OtherSubClass;
				superclass: (builder classNamed:#OtherClass);
				slots: #();
				category: 'AtomicClassInstaller-Tests' ]
]

{ #category : #'test class creation' }
AbstractAtomicInstallerTest >> buildSecondClass [
	Smalltalk classInstaller
		make: [ :builder | 
			builder
				name: #SecondClass;
				slots: #(aVariable);
				category: 'AtomicClassInstaller-Tests' ].
			
	self secondClass
		compile:
			'
		aVariable
			^aVariable.
	'.
	self secondClass
		compile:
			'
		aVariable: aValue
			aVariable := aValue.
	'.

]

{ #category : #'test classes' }
AbstractAtomicInstallerTest >> classWithClassVariable [
	^self environment at:#ClassWithClassVariable
]

{ #category : #running }
AbstractAtomicInstallerTest >> commonAsserts [
	Smalltalk environment organization assertInvariant.

]

{ #category : #'test class creation' }
AbstractAtomicInstallerTest >> compile: aSourceCode on:aClass [
	SystemAnnouncer uniqueInstance suspendAllWhile: [ aClass compile: aSourceCode ].
]

{ #category : #accessing }
AbstractAtomicInstallerTest >> environment [
	^ Smalltalk globals
]

{ #category : #'test classes' }
AbstractAtomicInstallerTest >> newClassWithTrait [
	^ self environment at:#NewClassWithTrait.
]

{ #category : #'test classes' }
AbstractAtomicInstallerTest >> oldClass [
	^ self environment at:#OldClass.
]

{ #category : #'test classes' }
AbstractAtomicInstallerTest >> oldComparableClass [
	^ self environment at:#OldComparableClass.
]

{ #category : #'test classes' }
AbstractAtomicInstallerTest >> otherClass [
	^ self environment at:#OtherClass.
]

{ #category : #'test classes' }
AbstractAtomicInstallerTest >> otherSubClass [
	^ self environment at:#OtherSubClass.
]

{ #category : #'test classes' }
AbstractAtomicInstallerTest >> performTest [
	super performTest.
	self commonAsserts.
]

{ #category : #accessing }
AbstractAtomicInstallerTest >> receivedAnnouncements [
	^ receivedAnnouncements
]

{ #category : #running }
AbstractAtomicInstallerTest >> removeClassIfExists: aClassName [
	self environment at:aClassName ifPresent:[:x | x removeFromSystem].
]

{ #category : #'test classes' }
AbstractAtomicInstallerTest >> secondClass [
	^ self environment at:#SecondClass.
]

{ #category : #running }
AbstractAtomicInstallerTest >> setUp [
	super setUp.

	receivedAnnouncements := OrderedCollection new.
	
	AtomicClassInstaller reset.
	
	self buildOldClass.
	self buildOldComparableClass.
	self buildOtherClass.
	self buildOtherSubClass.
	self buildSecondClass.
	self buildClassWithClassVariable.	
	
	AtomicClassInstaller reset.
	AtomicClassInstaller autocommit: false.

	SystemAnnouncer uniqueInstance weak when: Announcement send: #announcementReceived: to: self. 
]

{ #category : #running }
AbstractAtomicInstallerTest >> tearDown [
	self removeClassIfExists:#NewClassWithTrait.
	self removeClassIfExists:#OldComparableClass.
	self removeClassIfExists:#OldClass.
	self removeClassIfExists:#OtherClass.
	self removeClassIfExists:#OtherSubClass.	
	self removeClassIfExists:#SecondClass.	
	self removeClassIfExists: #ClassWithClassVariable.
	
	AtomicClassInstaller autocommit: true.

	SystemAnnouncer uniqueInstance unsubscribe: self.
	
	super tearDown.

]
