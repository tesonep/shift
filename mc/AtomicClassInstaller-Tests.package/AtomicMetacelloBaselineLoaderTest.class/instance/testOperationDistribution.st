as yet unclassified
testOperationDistribution
	| patch |
	patch := baselineLoader patch.
	patch applyTo: patcher.

	self assert: (patcher packageAdditions allSatisfy: [ :e | e isOrganizationDefinition ]).
	self assert: (patcher classAdditions allSatisfy: [ :e | e isClassDefinition ]).
	self assert: (patcher methodAdditions allSatisfy: [ :e | e isMethodDefinition ]).
	self assert: patcher packageAdditions size + patcher classAdditions size + patcher methodAdditions size equals: patch operations size