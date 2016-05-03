as yet unclassified
setUp
	super setUp.

	AtomicClassInstaller reset.

	PharoClassInstaller
		make: [ :builder | 
			builder
				name: #OldComparableClass;
				traitComposition: TComparable;
				slots: #(firstVariable);
				category: 'AtomicClassInstaller-Tests' ].