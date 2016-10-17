accessing environment
layoutType
	| layoutType |
	layoutType := buildEnvironment
		classNamed: self layoutDefinition layoutClass.
	
	"If there is no layouttype in the environment. Look for in the default environment"

	layoutType
		ifNil: [ layoutType := Smalltalk at: self layoutDefinition layoutClass ].
	^ layoutType