accessing
impact
	| packageOrganizer newPackage oldPackage tagName tag |
	self installer newOrganizer classify: modifiedClass name under: newCategory.
	packageOrganizer := self installer packageOrganizer.

	newPackage := packageOrganizer packageMatchingExtensionName: newCategory.
	tagName := (newCategory includes: $-)
		ifTrue: [ newCategory copyAfter: $- ]
		ifFalse: [ newCategory ].
	tag := newPackage classTagNamed: tagName ifAbsent:[ newPackage addClassTag: tagName ].


	SystemAnnouncer uniqueInstance
		suspendAllWhile: [ oldCategory
				ifNotNil: [ oldPackage := packageOrganizer packageMatchingExtensionName: oldCategory.
					newPackage moveClass: modifiedClass fromPackage: oldPackage toTag: tag ]
				ifNil: [ newPackage importClass: modifiedClass inTag: tag ] ].
			
	^ self.