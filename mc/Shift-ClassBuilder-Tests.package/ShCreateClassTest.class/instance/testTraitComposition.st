as yet unclassified
testTraitComposition
	result := builder
		name: #SHClassWithTraitComposition;
		traitComposition: TComparable;
		build.

	self validateResult.
	self validateSuperclass: Object.
	self validateSlots: #().
   self assert: (result canUnderstand: #>).
