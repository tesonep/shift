as yet unclassified
testNewProcessLocateProcesses
	| ps | 
	
	process := [ semaphore ifNotNil:#wait ] fork.
	
	ps := APProcessTool new nonSystemProcesses.
	self assert: ps isNotEmpty.