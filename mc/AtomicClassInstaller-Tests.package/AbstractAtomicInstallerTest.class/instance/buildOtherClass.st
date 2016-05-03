test class creation
buildOtherClass
	PharoClassInstaller
		make: [ :builder | 
			builder
				name: #OtherClass;
				slots: #();
				category: 'AtomicClassInstaller-Tests' ]