as yet unclassified
setUp
	super setUp.
	builder := ShiftClassBuilder new.
	builder buildEnvironment: ShSmalltalkGlobalsEnvironment new.