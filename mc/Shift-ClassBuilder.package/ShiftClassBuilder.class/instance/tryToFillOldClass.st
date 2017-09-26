accessing
tryToFillOldClass
	oldClass ifNotNil: [ ^self ].
	self oldClass: (self buildEnvironment classNamed: self name)