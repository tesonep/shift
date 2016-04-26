as yet unclassified
testChangingSuperclass
	| class |

	self assert: (Object subclasses includes: OldClass).

	class := AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #OtherClass;
				superclass: (builder classNamed:#OldClass);
				slots: #();
				category: 'AtomicClassInstaller-Tests' ].
					
	self assert: OtherClass ~= class.
	self assert: OtherClass methods size equals: class methods size.
	self assert: (OtherClass methods allSatisfy: [ :mOld | class methods anySatisfy: [:mNew | mOld selector = mNew selector ]]).
	self assert: class superclass name equals: #OldClass.
	self deny: (OldClass subclasses includes: class).
	self assert: (Object subclasses includes: OldClass).
	
	AtomicClassInstaller commit.

	self assert: OtherClass superclass equals: OldClass.
	self assert: (OldClass subclasses includes: OtherClass).
	self deny: (Object subclasses includes: OtherClass).
