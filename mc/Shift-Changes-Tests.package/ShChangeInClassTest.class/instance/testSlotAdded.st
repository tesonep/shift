as yet unclassified
testSlotAdded
	| old new changesInSlots slotChange |
	old := self shTestClassA.
	new := self shTestClassANew.
	results := old compareTo: new.

	changesInSlots := results select: [ :e | ShSlotChange allSubclasses includes: e class ].
	
	self assert: changesInSlots size equals:1.

	slotChange := changesInSlots at:1.

	self assert: slotChange class equals: ShSlotAdded.
	self assert: slotChange slotName equals: #otherSlot.
	self assert: slotChange slotType equals: #InstanceVariableSlot 