tests
testChangeName
	| old new changeNameDifference |
	old := self shTestClassA.
	new := self shTestClassB.
	results := old compareTo: new.
	changeNameDifference := results
		detect: [ :e | e class = ShClassRename ]
		ifNone: [ self fail: 'It should have detected the change in the name' ].
	self assert: changeNameDifference oldValue equals: #ShTestClassA.
	self assert: changeNameDifference newValue equals: #ShTestClassB