checking change
fillFrom: oldDefinition to: newDefinition
	^ self
		oldValue: (oldDefinition perform: self propertyAccesor);
		newValue: (newDefinition perform: self propertyAccesor);
		yourself