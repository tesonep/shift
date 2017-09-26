building
build	
	self tryToFillOldClass.

	self createMetaclass.
	self createClass.

	self comment ifNotNil: [ newClass classComment: self comment stamp: self commentStamp ].

	self createSharedVariables.

	self oldClass ifNotNil: [ 
			self newClass basicCategory: self oldClass basicCategory.
			builderEnhancer compileMethodsFor: self. ].

	builderEnhancer afterMethodsCompiled: self.
	
	self installSlots.
	
	^ newClass