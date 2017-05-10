class building
installTraitComposition: aTraitComposition on: aClass from: anOldClass
	| oldComposition |
	aTraitComposition assertValidUser: aClass.

	oldComposition := anOldClass ifNil: [ #() asTraitComposition ] ifNotNil: [ anOldClass traitComposition ].

	aClass traitComposition: aTraitComposition.
	aClass applyChangesOfNewTraitCompositionReplacing: oldComposition