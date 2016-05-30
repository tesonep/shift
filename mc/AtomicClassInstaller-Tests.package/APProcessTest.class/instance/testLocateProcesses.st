as yet unclassified
testLocateProcesses
	| ps | 
	ps := APProcessTool new nonSystemProcesses.
	self assertCollection: ps equals: #().