comparing
compare: oldClass with: aBuilder
	| aComparer changes |
	aComparer := self new.
	self builder: aBuilder.
	
	changes := aComparer compare: oldClass with: aBuilder.
	
	changes do:[:e | aBuilder addChange: e].