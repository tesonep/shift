initialization
initialize
	super initialize.
	innerClassInstaller := PharoClassInstaller new.
	changedClasses := Dictionary new.
	newClasses := OrderedCollection new.
	operations := OrderedCollection new.
	alreadyCommited := false.
	
	objectMigratorProvider := ACIDefaultObjectMigratorProvider new.

" I initialize the newEnvironment with the same associations (identicals), after if we changed them a new one is put in the new environment."
	newEnvironment := Smalltalk globals shallowCopy. 
	newEnvironment instVarNamed: #array  put: (newEnvironment array) copy.
	
	autocommit := true.