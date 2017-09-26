as yet unclassified
superclass
	^ superclass ifNil:[buildEnvironment classNamed: (self superclassName)]