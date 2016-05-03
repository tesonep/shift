running
tearDown
	self environment at:#OldComparableClass ifPresent:[:x | x removeFromSystem].
	self environment at:#OldClass ifPresent:[:x | x removeFromSystem].
	self environment at:#OtherClass ifPresent:[:x | x removeFromSystem].
	
	super tearDown.
