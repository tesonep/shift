as yet unclassified
testCreatePatch
	| mcVersion patch firstOperation |
	mcVersion := mcRepo versionFrom: self targetVersion.
	patch := AtomicPatch fromMCVersions: {mcVersion}.

	self assert: patch operations size equals: 17.
	firstOperation := patch operations at: 2.

	self assert: firstOperation class equals: APModifyClass.
	self assert: firstOperation definedClassName equals: #ACISubclass.