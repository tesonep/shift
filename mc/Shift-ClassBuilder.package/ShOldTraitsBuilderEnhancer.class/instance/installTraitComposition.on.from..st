building
installTraitComposition: anObject on: aClass from: anOldClass
	| oldComposition aTraitComposition |
	aTraitComposition := anObject asTraitComposition.
	aTraitComposition assertValidUser: aClass.

	oldComposition := #() asTraitComposition.

	aClass traitComposition: aTraitComposition.

	aClass applyChangesOfNewTraitCompositionReplacing: oldComposition.