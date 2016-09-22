tests
testChangeTraitComposition
	| old new categoryChange |
	old := self shTestClassC.
	new := self shTestClassCWithoutTrait.
	results := old compareTo: new.

	categoryChange := results
		detect: [ :e | e class = ShTraitCompositionChange ]
		ifNone: [ self fail: 'It should have detected the change in the traitComposition ' ].

	self assert: categoryChange oldValue equals: 'TShTestTrait'.
	self assert: categoryChange newValue equals: '{}'