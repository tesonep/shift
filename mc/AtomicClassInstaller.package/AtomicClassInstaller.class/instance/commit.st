actions
commit
	| oldObjects newObjects objectsToMigrate|
	
	oldObjects := OrderedCollection new.
	newObjects := OrderedCollection new.
	objectsToMigrate := OrderedCollection new.
	
	[ 
		changedClasses valuesDo: [ :a | 
			oldObjects add: a key. 
			newObjects add: a value.
						
			objectsToMigrate addAll:(self migrateObjectsFrom: a key to: a value). 
		 ].

		objectsToMigrate do:[ :a | 
			oldObjects add: a key. 
			newObjects add: a value.
		].

		changedClasses removeAll.
		objectsToMigrate removeAll.
					
		newEnvironment := SystemDictionary new addAll:Smalltalk globals.
		
		newClasses do:[ :cls | 
			newEnvironment at: cls name put: cls.
		].
		
		newClasses removeAll.
		
		oldObjects add:Smalltalk globals.
		newObjects add:newEnvironment.
								
		oldObjects asArray elementsForwardIdentityTo: newObjects asArray.
		  
	] valueUnpreemptively.

	HashedCollection allSubInstancesDo:#rehash. 
