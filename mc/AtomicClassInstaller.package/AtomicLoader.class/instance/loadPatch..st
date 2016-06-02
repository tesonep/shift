as yet unclassified
loadPatch: aPatch
	patch := aPatch.
	
	AtomicClassInstaller reset.
	
	AtomicClassInstaller uniqueInstance objectMigratorProvider: self.
	
	processTool addAllModifiedMethod: aPatch modifiedMethods.
	processTool waitAllQuiescent.
	patch applyAll.
	
	AtomicClassInstaller commit