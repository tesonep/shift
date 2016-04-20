as yet unclassified
make: aBlock
	| builder |
	builder := self uniqueInstance builder.
	aBlock value: builder.
	^ builder build