class building
installTraitComposition: aTraitComposition on: aClass from: oldClass
	| oldComposition |
	aTraitComposition assertValidUser: aClass.

	oldComposition := oldClass ifNil: [ #() asTraitComposition  ] ifNotNil: [ oldClass traitComposition].
	aClass traitComposition: aTraitComposition.
	aClass applyChangesOfNewTraitCompositionReplacing: oldComposition.