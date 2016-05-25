as yet unclassified
resumeProcess: aProcess
 	| aList |
	aList := suspendedLists at: aProcess.
	^aList addLast: aProcess. 