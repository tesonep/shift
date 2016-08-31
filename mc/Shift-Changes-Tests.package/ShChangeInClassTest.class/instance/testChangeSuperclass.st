as yet unclassified
testChangeSuperclass
	| old new change |
	old := ShTestClassA asRingDefinition.
	new := ShTestClassC asRingDefinition.
	results := old compareTo: new.
	change := results
		detect: [ :e | e class = ShSuperclassChange ]
		ifNone: [ self fail: 'It should have detected the change' ].

	self assert: change oldSuperclassName equals: #Object.
	self assert: change newSuperclassName equals: #ShTestClassB.