as yet unclassified
testDetectingQuiescentProcesses
	| process2 mockProcess tool | 
	
	process := [ semaphore wait ] fork.

	mockProcess := APMockProcess new.
	mockProcess semaphore: semaphore.

	process2 := [ mockProcess run ] fork.
	
	Processor yield.
	
	tool := APProcessTool new.
	tool addModifiedMethod: #(APMockProcess #run).
	
	self assert: (tool isQuiescent: process).
	self deny: (tool isQuiescent: process2).
