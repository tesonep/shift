tests
testSlotRemoved
	| old new changesInSlots slotChange |
	old := self shFTestClassANew.
	new := self shFTestClassA.
	results := old compareTo: new.

	changesInSlots := results select: [ :e | ShSlotChange allSubclasses includes: e class ].
	
	self assert: changesInSlots size equals:1.

	slotChange := changesInSlots at:1.

	self assert: slotChange class equals: ShSlotRemoved.
	self assert: slotChange slotName equals: #otherSlot.
	self assert: slotChange slotType equals: #InstanceVariableSlot.
	self assert: slotChange slotSide equals: #instance.