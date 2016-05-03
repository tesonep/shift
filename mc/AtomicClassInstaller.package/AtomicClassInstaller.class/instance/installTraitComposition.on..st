traits
installTraitComposition: aTraitComposition on: aClass
	| oldComposition |
	(aClass hasTraitComposition not and: [aTraitComposition isEmpty]) ifTrue: [^self].
	aTraitComposition assertValidUser: aClass.

	oldComposition := aClass traitComposition.
	aClass traitComposition: aTraitComposition.
	aClass applyChangesOfNewTraitCompositionReplacing: oldComposition.
	
	oldComposition traits do: [:each | self removeUser: aClass fromTrait: each].
	aTraitComposition traits do: [:each | self addUser: aClass ToTrait: each]
