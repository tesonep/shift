utils
updateLayoutInSubClassesFrom: oldClass to:newClass
	| oldSlotScope newSlotScope |
	oldSlotScope := oldClass layout slotScope.
	newSlotScope := newClass layout slotScope.

	newClass allSubclassesDo:[:e|
		self replaceSlotScope: oldSlotScope to:newSlotScope on: e.
	]