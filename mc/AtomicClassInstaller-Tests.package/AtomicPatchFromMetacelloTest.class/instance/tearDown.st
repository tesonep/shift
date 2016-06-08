as yet unclassified
tearDown
	baselineLoader baseline unload.
	baselineLoader metacello unregister.
	(RPackageOrganizer default packageNamed: 'TokyoDB' ifAbsent:[nil]) ifNotNil:[ :pck |
		RPackageOrganizer default unregisterPackage: pck
	].
	(MCWorkingCopy forPackage: (MCPackage named: 'TokyoDB')) unload .

	RPackageOrganizer initializeDefaultFromMC.

	super tearDown