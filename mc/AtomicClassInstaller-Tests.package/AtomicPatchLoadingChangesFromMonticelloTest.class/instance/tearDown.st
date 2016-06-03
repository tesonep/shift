as yet unclassified
tearDown
	MCWorkingCopy announcer suspendAllWhile: [ (MCWorkingCopy forPackage: (MCPackage named: 'AtomicClassInstaller-Tests-Code')) unload ].
	super tearDown