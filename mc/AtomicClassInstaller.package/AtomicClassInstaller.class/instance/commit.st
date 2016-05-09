actions
commit	
	oldObjects := OrderedCollection new.
	newObjects := OrderedCollection new.
	objectsToMigrate := OrderedCollection new.
	
	[ 
		oldOrganizer := Smalltalk globals organization.
		newOrganizer := oldOrganizer copy.
	
		operations do:#impact.
		operations removeAll.

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
					
		newEnvironment := SystemDictionary new addAll:Smalltalk globals; yourself.
		
		newClasses do:[ :cls | 
			newEnvironment at: cls name put: cls.
		].
		
		newClasses removeAll.
		
		newEnvironment == Smalltalk globals.
		
		oldObjects add:Smalltalk globals.
		newObjects add:newEnvironment.

		oldObjects add:oldOrganizer.
		newObjects add:newOrganizer.
		
		oldObjects with:newObjects do:[ :a :b | self assert:( a == b ) not].
															
		oldObjects asArray elementsForwardIdentityTo: newObjects asArray.
		  
	] valueUnpreemptively.
