building
build	
	self tryToFillOldClass.
	
	self compareWithOldClass.

	self createMetaclass.
	self createClass.

	"I should only comment the class if the new comment is different than the old comment."
	self comment ifNotNil: [ 
		(oldClass isNil or: [oldClass comment ~= self comment])
		ifTrue:[newClass classComment: self comment stamp: self commentStamp] ].

	self createSharedVariables.

	self oldClass ifNotNil: [ 
			self newClass basicCategory: self oldClass basicCategory.
			builderEnhancer compileMethodsFor: self. ].

	builderEnhancer afterMethodsCompiled: self.
	
	self installSlots.
	
	^ newClass