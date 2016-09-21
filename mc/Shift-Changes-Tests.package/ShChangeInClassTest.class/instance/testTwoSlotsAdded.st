tests
testTwoSlotsAdded
	| old new changesInSlots slotChange |
	old := self shTestClassB.
	new := self shTestClassANew.
	results := old compareTo: new.

	changesInSlots := results select: [ :e | ShSlotChange allSubclasses includes: e class ].
	
	self assert: changesInSlots size equals:2.

	slotChange := changesInSlots at:1.

	self assert: slotChange class equals: ShSlotAdded.
	self assert: slotChange slotName equals: #otherSlot.
	self assert: slotChange slotType equals: #InstanceVariableSlot.
	self assert: slotChange slotSide equals: #instance.
	
	slotChange := changesInSlots at:2.

	self assert: slotChange class equals: ShSlotAdded.
	self assert: slotChange slotName equals: #oneSlot.
	self assert: slotChange slotType equals: #InstanceVariableSlot.
	self assert: slotChange slotSide equals: #instance.