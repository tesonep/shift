as yet unclassified
interleave: anObject selector: aSelector afterContext: aContext
	| newContext method |
	method := anObject class lookupSelector: aSelector.
	newContext := Context newForMethod: method.
	newContext
		setSender: nil
		receiver: anObject
		method: method
		arguments: #().
	aContext insertSender: newContext