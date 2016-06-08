as yet unclassified
tearDown
	MCWorkingCopy announcer
		suspendAllWhile: [ (MCWorkingCopy forPackage: (MCPackage named: 'AtomicClassInstaller-Tests-Code')) unload ].

	(RPackageOrganizer default
		packageNamed: #'AtomicClassInstaller-Tests-Code'
		ifAbsent: [ nil ]) ifNotNil: [ :p | RPackageOrganizer default removePackage: p ].

	super tearDown