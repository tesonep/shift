migrating
migrateClasses: aCollectionOfOldClasses to: aCollectionOfNewClasses using: anInstanceModification 
	self flag: 'Todo - By now we check all the classes are recorded to be migrated'.
	self assert: [ changedClasses keys includesAll: (aCollectionOfOldClasses collect:#name)  ]