as yet unclassified
interleave: anObject selector: aSelector afterBlocked: aProcess 
	aProcess suspendedContext ifNotNil:[:aContext | |newContex method|
		method := anObject class lookupSelector: aSelector.
		newContex := Context newForMethod: method.
		newContex setSender: nil receiver: anObject method: method arguments: #().
		aContext insertSender: newContex
	]