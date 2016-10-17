class building
copyClassSlotsFromExistingClass
	| oldClass |
	oldClass := self environment at: name ifAbsent: [ ^ self ].

	self classSlots: oldClass class classLayout slotScope visibleSlots.