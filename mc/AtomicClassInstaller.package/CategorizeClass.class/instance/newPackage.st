accessing
newPackage
	^ (self packageOrganizer packageMatchingExtensionName: newCategory) ifNil: [ self packageOrganizer registerPackage: (RPackage named: newCategory) ]