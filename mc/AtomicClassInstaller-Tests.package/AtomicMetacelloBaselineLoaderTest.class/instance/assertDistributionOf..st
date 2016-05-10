as yet unclassified
assertDistributionOf: patch
	self assert: (patcher packageAdditions allSatisfy: [ :e | e isOrganizationDefinition ]).
	self assert: (patcher classAdditions allSatisfy: [ :e | e isClassDefinition ]).
	self assert: (patcher methodAdditions allSatisfy: [ :e | e isMethodDefinition ]).
	self assert: (patcher packageRemoves allSatisfy: [ :e | e isOrganizationDefinition ]).
	self assert: (patcher classRemoves allSatisfy: [ :e | e isClassDefinition ]).
	self assert: (patcher methodRemoves allSatisfy: [ :e | e isMethodDefinition ]).

	self assert: patcher numberOfOperations equals: patch operations size