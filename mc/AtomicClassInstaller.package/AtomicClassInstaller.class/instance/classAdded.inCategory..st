notifications
classAdded: aClass inCategory: aString 
	newClasses add: aClass.
	aClass basicCategory: aString.
	newEnvironment at: aClass name put: aClass.
	
	AddSubclass for: self class: aClass superclass: aClass superclass.
	CategorizeClass for: self class: aClass newCategory: aString asSymbol.