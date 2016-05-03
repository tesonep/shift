accessing
initialize
	super initialize.
	innerClassInstaller := PharoClassInstaller new.
	changedClasses := Dictionary new.
	newClasses := OrderedCollection new.
	operations := OrderedCollection new.