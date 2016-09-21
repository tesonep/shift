tests
testClassSideSlotRemoved
	| old new changesInSlots slotChange |
	old := self shTestClassAWithClassVariable.
	new := self shTestClassA.
	results := old compareTo: new.

	changesInSlots := results select: [ :e | ShSlotChange allSubclasses includes: e class ].
	
	self assert: changesInSlots size equals:1.

	slotChange := changesInSlots at:1.

	self assert: slotChange class equals: ShSlotRemoved.
	self assert: slotChange slotName equals: #aClassSideVariable.
	self assert: slotChange slotType equals: #InstanceVariableSlot.
	self assert: slotChange slotSide equals: #metaclass