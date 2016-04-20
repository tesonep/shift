notifications
migrateObjectsFrom: oldClass to: newClass
	| oldInstances variable instSize result |
	
	oldInstances := oldClass allInstances asArray.
		 	
	oldInstances isEmpty
		ifTrue: [ ^ nil ].	"no instances to convert"
	newClass isMeta ifTrue:
		[(oldInstances size = 1
		  and: [newClass soleInstance class == newClass
				or: [newClass soleInstance class == oldClass]]) ifFalse:
			[^self error: 'Metaclasses can only have one instance']].
	
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
