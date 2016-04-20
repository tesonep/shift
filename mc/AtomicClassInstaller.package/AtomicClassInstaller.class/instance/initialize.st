accessing
initialize
	super initialize.
	innerClassInstaller := PharoClassInstaller new.
	changedClasses := Dictionary new.