as yet unclassified
testResumeOfAProcess	
	| s2 suspendingList |
	s2 := Semaphore new.
	process := [ semaphore wait. s2 signal. ] fork.	
	suspendingList := process suspend.
	
	self assert: (s2 waitTimeoutSeconds: 1).

	semaphore signal.	
	suspendingList addLast:process.
	
	self deny: (s2 waitTimeoutSeconds: 1).