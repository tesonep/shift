building
make: aBlock
	| newClass oldClass builder |
	
	builder := ShiftClassBuilder new.
	builder buildEnvironment: ShSmalltalkGlobalsEnvironment new.	
	
	aBlock value: builder.
	newClass := builder build.
	
	oldClass := builder environment at: (builder name) ifAbsent:[].
		
	builder environment at: (builder name) put: newClass.
	
	newClass superclass addSubclass: newClass.
	
	builder builderEnhancer beforeMigratingClass: builder installer: self.
	
	oldClass ifNotNil:[
		self migrateClassFrom:oldClass to:newClass].
	
	self recategorize: newClass  to: builder category builder: builder.
	
	newClass subclasses do:[:e | self remake: e ].
	
	^ newClass.