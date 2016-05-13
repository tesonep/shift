as yet unclassified
testApplying
	| patch |	

	patch := baselineLoader patch.
	patch applyTo: patcher.

	self assertDistributionOf: patch.
	
	patcher applyAll.

	self deny:(Smalltalk environment hasClassNamed: #TokyoLibrary).
	self deny:(Smalltalk environment hasClassNamed: #TokyoObject).	
	
	AtomicClassInstaller commit.
	baselineLoader fixMonticelloPackage.
	
	self assert:(Smalltalk environment hasClassNamed: #TokyoLibrary).
	self assert:(Smalltalk environment hasClassNamed: #TokyoObject).	
	self assert:((Smalltalk environment at: #TokyoLibrary) methodDict includesKey: #unixModuleName).	