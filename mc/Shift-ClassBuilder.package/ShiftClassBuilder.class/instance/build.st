class building
build
	self createMetaclass.
	self createClass.

	self comment ifNotNil: [ newClass classComment: self comment stamp: self commentStamp ].

	self createSharedVariables.

	(buildEnvironment hasClassNamed: self name)
		ifTrue: [ oldClass := buildEnvironment classNamed: self name.
			oldMetaclass := oldClass class.
			newClass basicCategory: oldClass basicCategory.
			builderEnhancer compileMethodsFor: self. ].

	self installTraits.
	self installSlots.
	
	^ newClass