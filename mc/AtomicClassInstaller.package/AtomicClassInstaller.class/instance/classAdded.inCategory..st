notifications
classAdded: aClass inCategory: aString 
	newClasses add: aClass.
	self addSubclass: aClass to: aClass superclass.