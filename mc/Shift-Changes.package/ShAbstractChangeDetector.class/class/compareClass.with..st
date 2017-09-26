comparing
compareClass: oldClass with: aBuilder
	| aComparer changes |
	aComparer := self new.
	aComparer builder: aBuilder.
	
	changes := aComparer compareClass: oldClass with: aBuilder.
	
	changes do:[:e | aBuilder addChange: e].