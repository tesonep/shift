as yet unclassified
setUp
	super setUp.
	builder := ShiftClassBuilder new.
	builder environment: ShSmalltalkGlobalsEnvironment new.