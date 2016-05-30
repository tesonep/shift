as yet unclassified
testLocateProcesses
	| ps | 
	
	(Delay forSeconds: 5) wait.
	
	ps := APProcessTool new nonSystemProcesses.
	self assertCollection: ps equals: #().