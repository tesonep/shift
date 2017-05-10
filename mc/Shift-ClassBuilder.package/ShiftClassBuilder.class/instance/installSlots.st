class building
installSlots
	newClass classLayout slots
		do: [ :each | each installingIn: newClass ].
	newClass classLayout slots
		do: [ :each | each layoutChanged: newClass ]