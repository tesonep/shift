checking change
fillFrom: oldDefinition to: newDefinition
	^ self
		oldSuperclassName: oldDefinition superclassName;
		newSuperclassName: newDefinition superclassName;
		yourself