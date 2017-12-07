Class {
	#name : #ChangingSuperclassClassTest,
	#superclass : #AbstractAtomicInstallerTest,
	#category : 'AtomicClassInstaller-Tests'
}

{ #category : #tests }
ChangingSuperclassClassTest >> testChangingSuperclass [
	| class obj |
	obj := self otherClass new.
	self assert: obj class instSize equals: 0.
	self assert: (Object subclasses includes: self oldClass).

	class := AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #OtherClass;
				superclass: (builder classNamed:#OldClass);
				slots: #();
				category: 'AtomicClassInstaller-Tests' ].
					
	self assert: self otherClass ~= class.
	self assert: self otherClass methods size equals: class methods size.
	self assert: (self otherClass methods allSatisfy: [ :mOld | class methods anySatisfy: [:mNew | mOld selector = mNew selector ]]).
	self assert: class superclass name equals: #OldClass.
	self deny: (self oldClass subclasses includes: class).
	self assert: (Object subclasses includes: self oldClass).
	
	self assertNonAnnouncements.
	AtomicClassInstaller commit.
		
	self assert: self otherClass equals: class.
	self assert: self otherClass superclass equals: self oldClass.
	self assert: (self oldClass subclasses includes: self otherClass).
	self deny: (Object subclasses includes: self otherClass).
	
	self assert: obj class instSize equals: 2.

]

{ #category : #tests }
ChangingSuperclassClassTest >> testChangingVariablesInSuperclassAndMigration [
	| obj |
	obj := self otherSubClass new.
	self assert: obj class instSize equals:0. 
	
	AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #OtherClass;
				superclass: (builder classNamed:#OldClass);
				slots: #(aVariable);
				category: 'AtomicClassInstaller-Tests' ].

	self assertNonAnnouncements.
	AtomicClassInstaller commit.
	
	self assert: obj class instSize equals:3.
	self assert: (obj instVarNamed: #aVariable) equals: nil.

]

{ #category : #tests }
ChangingSuperclassClassTest >> testPreservingValuesAfterChangingSuperClass [
	| class obj |
	obj := self secondClass new.
	obj aVariable: 42.
	self assert: obj class instSize equals: 1.
	self assert: (Object subclasses includes: self oldClass).

	class := AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #SecondClass;
				superclass: (builder classNamed:#OldClass);
				slots: #(aVariable);
				category: 'AtomicClassInstaller-Tests' ].

	self assertNonAnnouncements.						
	AtomicClassInstaller commit.
		
	self assert: obj class instSize equals: 3.
	self assert: obj aVariable equals: 42.
	
	obj firstVariable: 23.
	self assert: obj firstVariable equals: 23.
]
