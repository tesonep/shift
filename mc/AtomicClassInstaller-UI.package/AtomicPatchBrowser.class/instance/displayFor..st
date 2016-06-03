as yet unclassified
displayFor: aValue
	aValue isSymbol ifFalse: [ ^aValue asString ].
	^ labels at:aValue.