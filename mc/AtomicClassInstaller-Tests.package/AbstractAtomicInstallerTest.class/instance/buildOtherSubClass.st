test class creation
buildOtherSubClass
	PharoClassInstaller
		make: [ :builder | 
			builder
				name: #OtherSubClass;
				superclass: (builder classNamed:#OtherClass);
				slots: #();
				category: 'AtomicClassInstaller-Tests' ]