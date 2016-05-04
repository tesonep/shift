notifications
classAdded: aClass inCategory: aString 
	newClasses add: aClass.
	AddSubclass for: self class: aClass superclass: aClass superclass.