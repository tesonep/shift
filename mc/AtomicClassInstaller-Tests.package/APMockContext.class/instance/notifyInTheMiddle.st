as yet unclassified
notifyInTheMiddle
	| r |
	r := thisContext pop.
	semaphore signal.
	^ r.