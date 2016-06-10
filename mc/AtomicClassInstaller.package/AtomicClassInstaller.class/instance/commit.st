actions
commit	
	alreadyCommited ifTrue:[ self error:'It should have been reseted'].
		
	oldObjects := OrderedCollection new.
	newObjects := OrderedCollection new.
	objectsToMigrate := OrderedCollection new.
	
	[ 
		alreadyCommited := true.
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
				
		oldObjects add:Smalltalk globals.
		newObjects add:newEnvironment.

		newEnvironment associationsDo:[:newAssoc | 
			Smalltalk globals	associationAt: newAssoc key ifPresent:[:oldAssoc | 
						(oldAssoc ~~ newAssoc) ifTrue:[
							oldObjects add:oldAssoc.
							newObjects add:newAssoc.
						]
				] 
		].

		oldObjects add:oldOrganizer.
		newObjects add:newOrganizer.
		
		oldObjects with:newObjects do:[ :a :b | self assert:( a == b ) not].
		self assert: [oldObjects allSatisfy: #isNotNil] .
		self assert: [newObjects allSatisfy: #isNotNil] .
																	
		oldObjects asArray elementsForwardIdentityTo: newObjects asArray.
		  
	] valueUnpreemptively.

self assert:[changedClasses values allSatisfy: [:kv | kv key == kv value ]].
self assert:[Smalltalk garbageCollect. (changedClasses values collect:#key thenSelect:#isMeta) allSatisfy: [:e | e allInstances size = 1]].

changedClasses removeAll.
newClasses removeAll.
objectsToMigrate removeAll.

self afterCommit.
