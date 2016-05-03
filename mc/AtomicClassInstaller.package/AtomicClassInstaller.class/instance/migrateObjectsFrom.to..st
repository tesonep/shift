migrating
migrateObjectsFrom: oldClass to: newClass
	| oldInstances variable instSize result |
	
	oldClass isTrait ifTrue:[ ^ #()].
	oldInstances := oldClass allInstances asArray.
		 	
	oldInstances isEmpty ifTrue: [ ^ #() ].	"no instances to convert"
		
	newClass isMeta ifTrue:[^#()].
	
	variable := newClass isVariable.
	instSize := newClass instSize.
	
	result := Array new: oldInstances size.
	
	1 to: oldInstances size do: [ :i | | old new | 
		old := oldInstances at: i.
		new := newClass newInstanceFrom: (oldInstances at: i) variable: variable size: instSize.
		result at: i 
			put: old -> new 
	].	
	
	^ result 
