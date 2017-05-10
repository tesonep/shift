class building
copyClassSlotsFromExistingClass
	| anOldClass |
	anOldClass := self environment at: name ifAbsent: [ ^ self ].

	self classSlots: anOldClass class classLayout slotScope visibleSlots.