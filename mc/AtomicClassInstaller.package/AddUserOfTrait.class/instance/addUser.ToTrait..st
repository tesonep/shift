traits
addUser: aClass ToTrait: aTrait 
	| changedTrait newSet |
	changedTrait := self classAt: aTrait name.
	newSet := changedTrait users reject:[:e | e name = aClass name].
	newSet add: aClass.
	changedTrait users:newSet.  