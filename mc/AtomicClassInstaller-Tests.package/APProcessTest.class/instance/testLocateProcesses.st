as yet unclassified
testLocateProcesses
	| ps | 
	ps := APProcessLocator new nonSystemProcesses.
	self assert: ps isEmpty.