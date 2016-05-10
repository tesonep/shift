as yet unclassified
testOperationDistribution
	| patch |
	patch := baselineLoader patch.
	patch applyTo: patcher.

	self assertDistributionOf: patch.