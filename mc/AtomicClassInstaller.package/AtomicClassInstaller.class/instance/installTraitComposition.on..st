traits
installTraitComposition: aTraitComposition on: aClass
	| oldComposition |
	
	(aClass hasTraitComposition not and: [aTraitComposition isEmpty]) ifTrue: [^self].
	aTraitComposition assertValidUser: aClass.

	oldComposition := aClass traitComposition.
	aClass traitComposition: aTraitComposition.
	aClass applyChangesOfNewTraitCompositionReplacing: oldComposition.

	oldComposition traits do: [:each | RemoveUserOfTrait on:self user: aClass trait: each].
	aTraitComposition traits do: [:each | AddUserOfTrait on:self user: aClass trait: each]
