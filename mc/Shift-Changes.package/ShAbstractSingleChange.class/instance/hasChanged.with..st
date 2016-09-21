checking change
hasChanged:oldDefinition with: newDefinition
	^ (oldDefinition perform: self propertyAccesor) ~= (newDefinition perform: self propertyAccesor)