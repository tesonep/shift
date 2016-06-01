utils
copyLayoutFrom: oldClass to: newClass
	| newLayout superclassName parentSlotScope |
	newLayout := oldClass layout copy host: newClass.
	superclassName := newClass superclass name.

	newLayout slotScope hasParent
		ifTrue: [ self
				basicClassAt: superclassName
				ifFound: [ :c | parentSlotScope := c layout slotScope ]
				ifAbsent: [ parentSlotScope := (self innerClassInstaller classAt: superclassName ifAbsent: [ self error: 'Could not found superclass ' , superclassName ]) layout slotScope ].
			newLayout slotScope parentScope: parentSlotScope ].

	newClass classLayout: newLayout