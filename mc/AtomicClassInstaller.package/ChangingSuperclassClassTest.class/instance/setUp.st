as yet unclassified
setUp
	super setUp.

	AtomicClassInstaller reset.

	PharoClassInstaller
		make: [ :builder | 
			builder
				name: #OtherClass;
				slots: #();
				category: 'AtomicClassInstaller-Tests' ].