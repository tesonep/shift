as yet unclassified
tearDown
	baselineLoader baseline unload.
	baselineLoader metacello unregister.
	(MCWorkingCopy forPackage: (MCPackage named: 'TokyoDB') ) unload.
	super tearDown.