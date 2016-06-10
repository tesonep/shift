utils
replaceSlotScope: oldSlotScope to: newSlotScope on: aClass
	| slotScope |
	slotScope := aClass layout slotScope.

	slotScope hasParent ifTrue:[
		slotScope parentScope: newSlotScope.
	]