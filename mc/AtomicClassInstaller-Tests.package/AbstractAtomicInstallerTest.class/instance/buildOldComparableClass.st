test class creation
buildOldComparableClass
	PharoClassInstaller
		make: [ :builder | 
			builder
				name: #OldComparableClass;
				traitComposition: TComparable;
				slots: #(#firstVariable);
				category: 'AtomicClassInstaller-Tests' ]