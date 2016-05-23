as yet unclassified
testLoadingTokyoDB
	| mcPatch |	

	mcPatch := baselineLoader mcPatch.
	atomicPatch := baselineLoader atomicPatch.
	
	atomicPatch applyAll.

	self deny:(Smalltalk environment hasClassNamed: #TokyoLibrary).
	self deny:(Smalltalk environment hasClassNamed: #TokyoObject).	
	
	AtomicClassInstaller commit.
	baselineLoader fixMonticelloPackage.
	
	self assert:(Smalltalk environment hasClassNamed: #TokyoLibrary).
	self assert:(Smalltalk environment hasClassNamed: #TokyoObject).	
	self assert:((Smalltalk environment at: #TokyoLibrary) methodDict includesKey: #unixModuleName).	