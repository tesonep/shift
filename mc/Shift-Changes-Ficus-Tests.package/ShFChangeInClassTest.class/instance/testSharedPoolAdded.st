tests
testSharedPoolAdded
	| old new changes sharedPoolChange |
	old := self shFTestClassA.
	new := self shFTestClassAWithSharedPool.
	results := old compareTo: new.

	changes := results select: [ :e | ShSharedPoolChange allSubclasses includes: e class ].
	
	self assert: changes size equals:1.

	sharedPoolChange := changes at:1.

	self assert: sharedPoolChange class equals: ShSharedPoolAdded.
	self assert: sharedPoolChange poolName equals: #ShFTestSharedPool.
	
