as yet unclassified
make: aBlock
	| builder result |
	
	Autocommit ifNil:[Autocommit := true].
	Autocommit ifTrue:[ self reset].
	
	builder := self uniqueInstance builder.
	aBlock value: builder.
	result := builder build.
	
	Autocommit ifTrue:[ self commit].
	^ result.