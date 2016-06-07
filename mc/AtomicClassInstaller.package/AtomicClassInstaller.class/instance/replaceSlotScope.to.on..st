utils
replaceSlotScope: oldSlotScope to: newSlotScope on: aClass
	| slotScope |
	slotScope := aClass layout slotScope.

	[ slotScope hasParent ]
		whileTrue: [ slotScope parentScope == oldSlotScope
				ifTrue: [ slotScope parentScope: newSlotScope.
					^ self ].
			slotScope := slotScope parentScope ]