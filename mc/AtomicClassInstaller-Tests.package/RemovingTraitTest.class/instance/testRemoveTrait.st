as yet unclassified
testRemoveTrait
	| class |

	
	self assert: (TComparable users includes: self oldComparableClass) .
	self assert: (self oldComparableClass canUnderstand: #max:).
	self assert: (self oldComparableClass canUnderstand: #min:).	

	class := AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #OldComparableClass;
				slots: #(firstVariable);
				category: 'AtomicClassInstaller-Tests' ].
	
	self assert: (TComparable users includes: self oldComparableClass) .
	self assert: (self oldComparableClass canUnderstand: #max:).
	self assert: (self oldComparableClass canUnderstand: #min:).	
	self deny: (Object subclasses includes: class).