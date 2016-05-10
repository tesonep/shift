as yet unclassified
testOperationDistribution2
	| patch inversePatch |
	patch := baselineLoader patch.
	inversePatch := MCPatch operations: ( patch operations collect:#inverse ).
	inversePatch applyTo: patcher.

	self assertDistributionOf: patch.