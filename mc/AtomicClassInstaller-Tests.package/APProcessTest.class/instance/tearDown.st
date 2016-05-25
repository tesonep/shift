as yet unclassified
tearDown
	semaphore ifNotNil: [ 
		semaphore signal.	
	]