as yet unclassified
tearDown
	baselineLoader baseline unload.
	baselineLoader metacello unregister.
	MCWorkingCopy announcer
		suspendAllWhile: [ (MCWorkingCopy forPackage: (MCPackage named: 'TokyoDB')) unload ].
	super tearDown