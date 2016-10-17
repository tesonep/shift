as yet unclassified
migrateClassFrom: oldClass to: newClass

	self assert: oldClass isNotNil.
	self assert: newClass isNotNil.
	
	oldClass superclass ~= newClass superclass ifTrue:[
		oldClass 	superclass removeSubclass: oldClass.
	].

	newClass class allSlots do: [ :newSlot | oldClass class slotNamed: newSlot name ifFound: [ :oldSlot | newSlot write: (oldSlot read: oldClass) to: newClass ] ].
	
	self migrateInstancesFrom: oldClass to: newClass.
	
	oldClass becomeForward: newClass copyHash: true