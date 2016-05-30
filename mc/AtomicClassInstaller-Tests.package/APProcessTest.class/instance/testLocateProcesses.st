as yet unclassified
testLocateProcesses
	| ps | 
	
	(Delay forSeconds: 5) wait.
	
	ps := ACIProcessTool new nonSystemProcesses.
	self assertCollection: ps equals: #().