as yet unclassified
make: aBlock
	| newClass oldClass |
	aBlock value: builder.
	newClass := builder build.
	
	oldClass := builder environment at: (builder name) ifAbsent:[].
		
	builder environment at: (builder name) put: newClass.
	
	newClass superclass addSubclass: newClass.
	
	oldClass ifNotNil:[
		self migrateClassFrom:oldClass to:newClass].
	
	self recategorize: newClass  to:  builder category.
	^ newClass.