as yet unclassified
setUp
	super setUp.

	AtomicClassInstaller reset.

	PharoClassInstaller
		make: [ :builder | 
			builder
				name: #OldClass;
				slots: #(#firstVariable #secondVariable);
				category: 'AtomicClassInstaller-Tests' ].
			
	OldClass methodDict removeKey: #thirdVariable ifAbsent:[].
	OldClass methodDict removeKey: #thirdVariable: ifAbsent:[].
