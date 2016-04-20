notifications
classDefinitionChangedFrom: oldClass to: newClass by: classModification 
	changedClasses at: newClass name put: (oldClass -> newClass).
	
	self
		copyMethodsFrom: oldClass to: newClass using: classModification;
		basicClassDefinitionChangedFrom: oldClass to: newClass using: classModification.