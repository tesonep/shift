traits
installTraitComposition: aTraitComposition on: aClass
	| oldComposition |
	(aClass hasTraitComposition not and: [aTraitComposition isEmpty]) ifTrue: [^self].
	aTraitComposition assertValidUser: aClass.

	self halt.

	oldComposition := aClass traitComposition.
	aClass traitComposition: aTraitComposition.
	aClass applyChangesOfNewTraitCompositionReplacing: oldComposition.
	
"	oldComposition traits do: [:each | each removeUser: aClass].
	aTraitComposition traits do: [:each | each addUser: aClass]
"