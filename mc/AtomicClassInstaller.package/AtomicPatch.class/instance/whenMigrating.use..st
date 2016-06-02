migrating
whenMigrating: aClassName use: blockOrCode
	| code |
	code := blockOrCode isClosure
		ifTrue: [ 
			self assert: blockOrCode isClean description: 'If the parameter is a block it should be clean'.
			blockOrCode asString ]
		ifFalse: [ blockOrCode ].
	transformations at: aClassName asSymbol put: code