as yet unclassified
testChangingSuperclass
	| class |
	class := AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #OtherClass;
				superclass: OldClass;
				slots: #();
				category: 'AtomicClassInstaller-Tests' ].
					
	self assert: OtherClass ~= class.
	self assert: OtherClass methods size equals: class methods size.
	self assert: (OtherClass methods allSatisfy: [ :mOld | class methods anySatisfy: [:mNew | mOld selector = mNew selector ]]).
	self assert: class superclass equals: OldClass.
	self deny: (OldClass subclasses includes: class).
	self assert: (Object subclasses includes: OldClass).
	
	self halt.
	AtomicClassInstaller commit.

	self assert: class superclass equals: OldClass.
	self assert: (OldClass subclasses includes: class).
	self deny: (Object subclasses includes: class).
