as yet unclassified
testClassWithSlots
	builder
		name: #SHTestClassWithSlots;
		slots: #(anSlot anotherSlot).

	result := builder build.

	self validateResult.
	self validateSuperclass: Object.
	self
		validateSlots:
			{(#anSlot => InstanceVariableSlot).
			(#anotherSlot => InstanceVariableSlot)}