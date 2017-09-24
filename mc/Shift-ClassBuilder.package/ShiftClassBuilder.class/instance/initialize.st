initialization
initialize
	super initialize.
	
	superclassName := #Object.
	layoutDefinition := ShLayoutDefinition new.
	builderEnhancer := self class defaultBuildEnhancer new.
	extensibleProperties := Dictionary new.
	
	builderEnhancer initializeBuilder: self.