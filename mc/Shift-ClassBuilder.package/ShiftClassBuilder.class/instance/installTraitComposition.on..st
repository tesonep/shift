class building
installTraitComposition: aTraitComposition on: aClass
	| oldComposition |
	(aClass hasTraitComposition not and: [aTraitComposition isEmpty]) ifTrue: [^self].
	aTraitComposition assertValidUser: aClass.

	oldComposition := aClass traitComposition.
	aClass traitComposition: aTraitComposition.
	aClass applyChangesOfNewTraitCompositionReplacing: oldComposition.