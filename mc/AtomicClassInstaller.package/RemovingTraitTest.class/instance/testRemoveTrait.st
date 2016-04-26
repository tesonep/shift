as yet unclassified
testRemoveTrait
	| class |

	
	self assert: (TComparable users includes: OldComparableClass) .
	self assert: (OldComparableClass canUnderstand: #max:).
	self assert: (OldComparableClass canUnderstand: #min:).	

	class := AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #OldComparableClass;
				slots: #(firstVariable);
				category: 'AtomicClassInstaller-Tests' ].
	
	self assert: (TComparable users includes: OldComparableClass) .
	self assert: (OldComparableClass canUnderstand: #max:).
	self assert: (OldComparableClass canUnderstand: #min:).	
	self deny: (Object subclasses includes: class).