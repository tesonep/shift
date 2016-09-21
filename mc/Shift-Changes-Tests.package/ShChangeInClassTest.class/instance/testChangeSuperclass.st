tests
testChangeSuperclass
	| old new change |
	old := self shTestClassA.
	new := self shTestClassC.
	results := old compareTo: new.
	change := results
		detect: [ :e | e class = ShSuperclassChange ]
		ifNone: [ self fail: 'It should have detected the change' ].

	self assert: change oldSuperclassName equals: #Object.
	self assert: change newSuperclassName equals: #ShTestClassB.