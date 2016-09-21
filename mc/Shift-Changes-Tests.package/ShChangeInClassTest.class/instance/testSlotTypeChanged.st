tests
testSlotTypeChanged
	| old new changesInSlots slotChange |
	old := self shTestClassWithDifferentSlotsOld.
	new := self shTestClassWithDifferentSlotsNew.
	results := old compareTo: new.
	
	changesInSlots := results select: [ :e | ShSlotChange allSubclasses includes: e class ].
	
	self assert: changesInSlots size equals:1.

	slotChange := changesInSlots at:1.

	self assert: slotChange class equals: ShSlotTypeChanged .
	self assert: slotChange slotName equals: #oneSlot.
	self assert: slotChange oldSlotType equals: #InstanceVariableSlot.
	self assert: slotChange newSlotType equals: #PropertySlot.
	self assert: slotChange slotSide equals: #instance.
