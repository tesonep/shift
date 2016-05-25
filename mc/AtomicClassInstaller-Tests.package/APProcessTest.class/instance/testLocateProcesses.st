as yet unclassified
testLocateProcesses
	| ps | 
	ps := APProcessTool new nonSystemProcesses.
	self assert: ps isEmpty.