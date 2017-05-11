class building
installTraitComposition: aTraitComposition on: aClass from: anOldClass
	| oldComposition |
	aTraitComposition assertValidUser: aClass.

	oldComposition := #() asTraitComposition.

	aClass traitComposition: aTraitComposition.
	aClass applyChangesOfNewTraitCompositionReplacing: oldComposition