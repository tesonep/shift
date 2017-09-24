as yet unclassified
migrateClassFrom: oldClass to: newClass
	| slotsToMigrate |
	self assert: oldClass isNotNil.
	self assert: newClass isNotNil.
	
	oldClass 	superclass removeSubclass: oldClass.

	newClass subclasses: oldClass subclasses.

	slotsToMigrate := newClass class allSlots reject:[:e | Class hasSlotNamed: e name].
	slotsToMigrate do: [ :newSlot | oldClass class slotNamed: newSlot name ifFound: [ :oldSlot | newSlot write: (oldSlot read: oldClass) to: newClass ] ].
	
	oldClass classVarNames do: [ :aClassVar |
		(newClass hasClassVarNamed: aClassVar) ifTrue:[ newClass classVarNamed: aClassVar put: (oldClass classVarNamed: aClassVar) ].
	].
	
	self migrateInstancesFrom: oldClass to: newClass.
	
	oldClass becomeForward: newClass copyHash: true