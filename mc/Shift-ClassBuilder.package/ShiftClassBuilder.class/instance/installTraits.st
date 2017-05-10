class building
installTraits
	self
		installTraitComposition: self traitComposition asTraitComposition
		on: newClass
		from: oldClass.
	self
		installTraitComposition: self classTraitComposition asTraitComposition
		on: newMetaclass
		from: oldMetaclass