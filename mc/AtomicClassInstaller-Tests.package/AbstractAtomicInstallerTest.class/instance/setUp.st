running
setUp
	super setUp.
	AtomicClassInstaller reset.
	
	self buildOldClass.
	self buildOldComparableClass.
	self buildOtherClass.