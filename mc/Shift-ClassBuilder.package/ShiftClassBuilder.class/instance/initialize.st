initialization
initialize
	super initialize.
	
	superclassName := #Object.
	builderEnhancer := self class defaultBuildEnhancer new.

	layoutDefinition := ShLayoutDefinition new.
	layoutDefinition builder: self.

	extensibleProperties := Dictionary new.
	
	changeComparers := OrderedCollection new.
	changes := OrderedCollection new.
		
	builderEnhancer initializeBuilder: self.