initialization
initialize
	super initialize.
	
	superclassName := #Object.
	layoutDefinition := ShLayoutDefinition new.
	classTraitComposition := ''.
	builderEnhancer := ShDefaultBuilderEnhancer new.
