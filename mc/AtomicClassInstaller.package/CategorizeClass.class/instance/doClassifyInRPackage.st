actions
doClassifyInRPackage
	" If the oldPackage does not exists the oldPackage = newPackage"

	self oldPackage = self newPackage
		ifTrue: [ self newPackage importClass: modifiedClass inTag: self tag.
			self packageOrganizer registerPackage: self newPackage forClass: modifiedClass ]
		ifFalse: [ self newPackage moveClass: modifiedClass fromPackage: self oldPackage toTag: self tag ]