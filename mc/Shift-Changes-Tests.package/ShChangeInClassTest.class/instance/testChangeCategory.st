tests
testChangeCategory
	| old new categoryChange |
	old := self shTestClassA.
	new := self shTestClassB.
	results := old compareTo: new.

	categoryChange := results
		detect: [ :e | e class = ShCategoryChange ]
		ifNone: [ self fail: 'It should have detected the change in the category' ].

	self assert: categoryChange oldValue equals: #'Shift-Changes-Tests-TestClasses'.
	self assert: categoryChange newValue equals: #'Shift-Changes-Tests-TestClassesB'