running
tearDown
	self removeClassIfExists:#NewClassWithTrait.
	self removeClassIfExists:#OldComparableClass.
	self removeClassIfExists:#OldClass.
	self removeClassIfExists:#OtherClass.
	
	super tearDown.
