interleaving contexts
interleaveBlock: aBlock afterBlockedProcess: aProcess
	| apContext |
	apContext := APContext new
		block: aBlock;
		yourself.
	^ self interleave: apContext selector: #doInTheMiddle afterContext: aProcess suspendedContext.