as yet unclassified
testClassWithInheritedSlots
	builder
		name: #SHTestEmptyClass;
		superclassName: #ShCBClassWithInstanceVariables;
		slots: #(anSlot anotherSlot).

	result := builder build.

	self validateResult.
	self validateSuperclass: ShCBClassWithInstanceVariables.
	self
		validateSlots:
			{#inheritedSlot => InstanceVariableSlot.
			#anSlot => InstanceVariableSlot.
			#anotherSlot => InstanceVariableSlot}