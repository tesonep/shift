utils
doCopyClass: oldClass
	| newClass |

	newClass := oldClass class copy new
		superclass: oldClass superclass;
		methodDict: oldClass methodDict copy;
		setFormat: oldClass format;
		setName: oldClass name;
		organization: oldClass organization copy;
		classPool: oldClass classPool copy;
		sharedPools: oldClass sharedPools copy.
	oldClass class instSize+1 to: oldClass class instSize do:
		[:offset | newClass instVarAt: offset put: (oldClass instVarAt: offset)].
	
	oldClass class allSlots do:[ :slot | slot write: (slot read:oldClass) to: newClass ].
	
	newClass classLayout: (oldClass layout copy host: newClass).
	newClass basicCategory: oldClass basicCategory.
	newClass environment: oldClass environment.
	newClass traitComposition: oldClass traitComposition.
	newClass subclasses: oldClass subclasses.
	newClass localSelectors: oldClass basicLocalSelectors copy.
	
	^ newClass.