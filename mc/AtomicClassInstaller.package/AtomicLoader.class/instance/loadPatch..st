as yet unclassified
loadPatch: aPatch
	patch := aPatch.
	processTool addAllModifiedMethod: aPatch modifiedMethods.
	processTool waitAllQuiescent.
	patch applyAll.
	AtomicClassInstaller commit