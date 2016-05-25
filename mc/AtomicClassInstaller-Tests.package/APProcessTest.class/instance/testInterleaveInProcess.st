as yet unclassified
testInterleaveInProcess
	| obj first second mockProcess p |
	first := Semaphore new.
	second := Semaphore new.
	
	obj := APMockContext new.
	obj semaphore: second.
	
	mockProcess := APMockProcess new.
	mockProcess semaphore: first.
	
	p := [ mockProcess run ] fork.
	
	Processor yield.
	
	APProcessTool new interleave: obj selector: #notifyInTheMiddle afterBlocked: p.
	
	first signal.
	
   self deny:(second waitTimeoutSeconds: 1).