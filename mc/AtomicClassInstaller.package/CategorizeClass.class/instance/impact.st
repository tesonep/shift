accessing
impact
	| packageOrganizer newPackage oldPackage tagName tag |
	self installer newOrganizer classify: modifiedClass name under: newCategory.
	packageOrganizer := self installer packageOrganizer.
	newPackage := packageOrganizer packageMatchingExtensionName: newCategory.
	newPackage
		ifNil: [ newPackage := RPackage named: newCategory.
			packageOrganizer registerPackage: newPackage ].
		
	tagName := newPackage toTagName: newCategory.
	tag := newPackage classTagNamed: tagName ifAbsent: [ newPackage addClassTag: tagName ].

	SystemAnnouncer uniqueInstance
		suspendAllWhile: [ oldCategory
				ifNotNil: [ oldPackage := packageOrganizer packageMatchingExtensionName: oldCategory.
					newPackage moveClass: modifiedClass fromPackage: oldPackage toTag: tag ]
				ifNil: [ newPackage importClass: modifiedClass inTag: tag ].
			
			packageOrganizer registerPackage: newPackage forClass: modifiedClass ].
	
	self assert: [ newPackage includesClass: modifiedClass ].
	self assert: [ (packageOrganizer packageOf: modifiedClass) == newPackage ].
