as yet unclassified
testLoadingTokyoDB
	| mcPatch suite testClasses result|	

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
	
	"Now I run the tests of TokyoDB to see if everything is ok"
	
	suite := TestSuite new.
	testClasses :=(RPackage organizer packageNamed: 'TokyoDB') definedClasses
		select:[:e | (e includesBehavior: TestCase) and:[e isAbstract not]].

	testClasses do:[:e | e addToSuiteFromSelectors:suite].
	result := suite run.	

	self assert: result errors size equals:0.
	self assert: result failures size equals:0. 