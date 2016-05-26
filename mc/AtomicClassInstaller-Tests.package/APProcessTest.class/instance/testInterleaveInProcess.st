as yet unclassified
testInterleaveInProcess
	| first second mockProcess p |
	first := Semaphore new.
	second := Semaphore new.
		
	mockProcess := APMockProcess new.
	mockProcess semaphore: first.
	
	p := [ mockProcess run ] fork.
	
	Processor yield.
	
	APProcessTool new interleaveBlock: [ second signal ]  afterBlockedProcess: p.
	
	first signal.
	
   self deny:(second waitTimeoutSeconds: 1).