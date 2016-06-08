running
setUp
	super setUp.
	
	AtomicClassInstaller reset.
	
	self buildOldClass.
	self buildOldComparableClass.
	self buildOtherClass.
	self buildOtherSubClass.
	self buildSecondClass.
	self buildClassWithClassVariable.	
	
	AtomicClassInstaller reset.
	AtomicClassInstaller autocommit: false.
