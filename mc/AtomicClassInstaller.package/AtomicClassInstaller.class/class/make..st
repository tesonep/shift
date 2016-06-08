as yet unclassified
make: aBlock
	| builder result |
	builder := self uniqueInstance builder.
	aBlock value: builder.
	result := builder build.
	self uniqueInstance autocommit ifTrue:[ self commit].
	^ result.