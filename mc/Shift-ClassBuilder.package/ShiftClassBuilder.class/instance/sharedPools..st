as yet unclassified
sharedPools: aString
	self layoutDefinition sharedPools: ((aString substrings: ' ') collect: #asSymbol)