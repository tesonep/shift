as yet unclassified
testCreatePatch
	| mcVersion patch firstOperation |
	mcVersion := mcRepo versionFrom: 'AtomicClassInstaller-Tests-Code-PabloTesone.2'.
	patch := AtomicPatch fromMCVersions: {mcVersion}.

	self assert: patch operations size equals: 9.
	firstOperation := patch operations at: 1.

	self assert: firstOperation class equals: APModifyClass.
	self assert: firstOperation definedClassName equals: #ACIUser.