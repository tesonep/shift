as yet unclassified
testOperationDistribution2
	| mcPatch inverseMCPatch |
	mcPatch := baselineLoader mcPatch.
	inverseMCPatch := MCPatch operations: ( mcPatch operations collect:#inverse ).
	atomicPatch := baselineLoader atomicPatch.
