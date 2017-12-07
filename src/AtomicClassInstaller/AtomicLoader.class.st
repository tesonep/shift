Class {
	#name : #AtomicLoader,
	#superclass : #Object,
	#instVars : [
		'processTool',
		'patch'
	],
	#category : 'AtomicClassInstaller-Loader'
}

{ #category : #'as yet unclassified' }
AtomicLoader >> initialize [
	super initialize.
	processTool := ACIProcessTool new.
]

{ #category : #'as yet unclassified' }
AtomicLoader >> loadPatch: aPatch [
	patch := aPatch.

	AtomicClassInstaller reset.
	AtomicClassInstaller autocommit: false.

	AtomicClassInstaller uniqueInstance objectMigratorProvider: patch.

	processTool addAllModifiedMethod: aPatch modifiedMethods.

	[ processTool waitAllQuiescent.
	patch applyAll.
	AtomicClassInstaller commit ] valueUnpreemptively
]
