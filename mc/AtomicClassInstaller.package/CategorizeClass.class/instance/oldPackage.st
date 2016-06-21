accessing
oldPackage
	^ oldPackage ifNil: [ self oldCategory ifNil: [ oldPackage := self newPackage ] ifNotNil: [ oldPackage := self packageOrganizer packageMatchingExtensionName: oldCategory ] ]