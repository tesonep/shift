as yet unclassified
testApplying
	| patch |	

	self skip.
	patch := baselineLoader patch.
	patch applyTo: patcher.

	self assertDistributionOf: patch.
	
	patcher applyAll.
	
	self assert:(Smalltalk environment hasClassNamed: #TokyoLibrary).
	self assert:(Smalltalk environment hasClassNamed: #TokyoObject).	
	self assert:((Smalltalk environment at: #TokyoLibrary) methodDict includesKey: #unixModuleName).	