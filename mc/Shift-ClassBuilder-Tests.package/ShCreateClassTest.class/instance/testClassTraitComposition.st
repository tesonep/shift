as yet unclassified
testClassTraitComposition
	result := builder
		name: #SHClassWithTraitComposition;
		classTraitComposition: TComparable;
		build.

	self validateResult.
	self validateSuperclass: Object.
	self validateSlots: #().
   self assert: (result class canUnderstand: #>).
