class building
build
	| newMetaclass newClass oldClass oldMetaClass |
	newMetaclass := Metaclass new.
	newMetaclass superclass: self superclass class withLayoutType: FixedLayout slots: self layoutDefinition classSlots.

	newClass := newMetaclass new.
	newClass setName: self name.

	newClass superclass: self superclass withLayoutType: self layoutType slots: self layoutDefinition slots.

	newClass environment: self buildEnvironment environment.

	self comment ifNotNil: [ newClass classComment: self comment stamp: self commentStamp ].

	newClass
		declareClassVariables: self layoutDefinition sharedVariables;
		sharing: self layoutDefinition sharedPoolsString.

	(buildEnvironment hasClassNamed: self name)
		ifTrue: [ 
			oldClass := buildEnvironment classNamed: self name.
			oldMetaClass := oldClass class.
			newClass basicCategory: oldClass basicCategory.
			newClass compileAllFrom: oldClass.
			newMetaclass compileAllFrom: oldMetaClass 
		].

	self installTraitComposition: self traitComposition asTraitComposition on: newClass from: oldClass.
	self installTraitComposition: self classTraitComposition asTraitComposition on: newMetaclass from:oldMetaClass.

	newClass classLayout slots do: [ :each | each installingIn: newClass ].
	newClass classLayout slots do: [ :each | each layoutChanged: newClass ].

	^ newClass