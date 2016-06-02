migrating
migrateObjectsFrom: oldClass to: newClass
	| oldInstances result migrator |
	
	oldClass isTrait ifTrue:[ ^ #()].
	newClass isMeta ifTrue:[ ^ #() ].
	
	oldInstances := oldClass allInstances asArray.
		 	
	oldInstances isEmpty ifTrue: [ ^ #() ].	"no instances to convert"
				
	(((newClass isVariable = oldClass isVariable) and:[ newClass instSize = oldClass instSize ]) 
		and:[ oldClass slots = newClass slots ]) ifTrue:[^#()].
	
	result := Array new: oldInstances size.
	migrator := objectMigratorProvider objectMigratorFor: oldClass to: newClass.  
	
	1 to: oldInstances size do: [ :i | | old new | 
		old := oldInstances at: i.
		new := self migrateSingleObject: old from: oldClass to:newClass using:migrator.
		result at: i 
			put: old -> new 
	].	
	
	^ result 
