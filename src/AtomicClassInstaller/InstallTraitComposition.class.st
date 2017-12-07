Class {
	#name : #InstallTraitComposition,
	#superclass : #TraitOperation,
	#category : 'AtomicClassInstaller-Operations'
}

{ #category : #'as yet unclassified' }
InstallTraitComposition >> impact [
	| oldComposition |
	oldComposition := self modifiedClass traitComposition.
	self modifiedClass traitComposition: self modifiedTrait.
	self modifiedClass applyChangesOfNewTraitCompositionReplacing: oldComposition.

]
