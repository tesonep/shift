tests
testChangeCommentary
	| old new categoryChange |
	old := self shTestClassA.
	new := self shTestClassAWithComment.
	results := old compareTo: new.

	categoryChange := results
		detect: [ :e | e class = ShCommentChange ]
		ifNone: [ self fail: 'It should have detected the change in the comment' ].

	self assert: categoryChange oldValue equals: 'A Test Class'.
	self assert: categoryChange newValue equals: 'A Test Class with a different comment'