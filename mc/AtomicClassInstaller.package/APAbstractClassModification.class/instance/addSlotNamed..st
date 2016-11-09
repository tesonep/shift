altering
addSlotNamed: aName
	slots := slots copyWith: (APSlotDefinition newInstanceVariable: aName).
