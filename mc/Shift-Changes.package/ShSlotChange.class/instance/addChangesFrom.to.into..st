checking change
addChangesFrom: oldDefinition to: newDefinition into: results
	| oldSlots newSlots |
	oldSlots := oldDefinition layout instanceVariables.
	newSlots := newDefinition layout instanceVariables.

	newSlots
		do: [ :new | 
			oldSlots
				detect: [ :old | old name = new name ]
				ifNone: [ results
						add:
							(ShSlotAdded new
								slotName: new name;
								slotType: #InstanceVariableSlot;
								yourself) ] ].

	oldSlots
		do: [ :old | 
			newSlots
				detect: [ :new | old name = new name ]
				ifNone: [ results
						add:
							(ShSlotRemoved new
								slotName: old name;
								slotType: #InstanceVariableSlot;
								yourself) ] ].
