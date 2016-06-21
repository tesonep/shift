actions
doClassifyInRPackage
	self oldPackage = self newPackage
		ifTrue: [ self newPackage importClass: modifiedClass inTag: self tag ]
		ifFalse: [ self newPackage moveClass: modifiedClass fromPackage: self oldPackage toTag: self tag ].
	self packageOrganizer registerPackage: self newPackage forClass: modifiedClass