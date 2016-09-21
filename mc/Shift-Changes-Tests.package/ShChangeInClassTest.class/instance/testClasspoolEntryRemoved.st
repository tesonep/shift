tests
testClasspoolEntryRemoved
	| old new changes classpoolChange |
	old := self shTestClassAWithClassPoolEntry.
	new := self shTestClassA.
	results := old compareTo: new.

	changes := results select: [ :e | ShClasspoolChange allSubclasses includes: e class ].
	
	self assert: changes size equals:1.

	classpoolChange := changes at:1.

	self assert: classpoolChange class equals: ShClasspoolRemoved.
	self assert: classpoolChange entryName equals: #AClassPoolEntry.
