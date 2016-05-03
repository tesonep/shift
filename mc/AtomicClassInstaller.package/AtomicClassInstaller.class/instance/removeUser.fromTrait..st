traits
removeUser: aClass fromTrait: aTrait
	| changedTrait |
	
	changedTrait := self classAt: aTrait name.
	changedTrait users: (changedTrait users reject:[:e | e name = aClass name]) 