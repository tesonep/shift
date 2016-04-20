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
			
			oldObjects add: a key class.
			newObjects add: a value class.
			
			objectsToMigrate addAll:(self migrateObjectsFrom: a key to: a value). 
		 ].

		objectsToMigrate do:[ :a | 
			oldObjects add: a key. 
			newObjects add: a value.
		].

		changedClasses removeAll.
		objectsToMigrate removeAll.
		
		oldObjects asArray elementsForwardIdentityTo: newObjects asArray.
	] valueUnpreemptively.

	HashedCollection allSubInstancesDo:#rehash. 
