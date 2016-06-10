utils
updateLayoutInSubClassesFrom: oldClass to:newClass
	| oldSlotScope newSlotScope |
	oldSlotScope := oldClass layout slotScope.
	newSlotScope := newClass layout slotScope.

	newClass subclassesDo:[:e|
		self assert:[self isChangedClass:e].
		self replaceSlotScope: oldSlotScope to:newSlotScope on: e.
		self assert:[e classLayout checkIntegrity. true.]
	]