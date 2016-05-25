as yet unclassified
testNewProcessLocateProcesses
	| ps | 
	
	process := [ semaphore ifNotNil:#wait ] fork.
	
	ps := APProcessLocator new nonSystemProcesses.
	self assert: ps isNotEmpty.