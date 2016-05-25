as yet unclassified
suspendProcess: aProcess
 	| aList |
	aList := aProcess suspend.
	suspendedLists at: aProcess put: aList.
	^aList.