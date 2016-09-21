tests
testNoChangeInLayout
	| old new categoryChange |
	old := self shTestClassA.
	new := self shTestClassANew.
	results := old compareTo: new.

	categoryChange := results
		detect: [ :e | e class = ShLayoutTypeChange ]
		ifFound: [ self fail: 'It should have not detected the change in the layout' ].
