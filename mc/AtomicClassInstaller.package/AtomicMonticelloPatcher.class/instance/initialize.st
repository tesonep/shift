initialization
initialize
	super initialize.
	packageAdditions := OrderedCollection new.
	classAdditions := OrderedCollection new.
	methodAdditions := OrderedCollection new.
	
	packageRemoves := OrderedCollection new.
	classRemoves := OrderedCollection new.
	methodRemoves := OrderedCollection new.		