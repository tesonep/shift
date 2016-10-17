as yet unclassified
migrateInstancesFrom: oldClass to: newClass
	| oldObjects newObjects |
	oldObjects := oldClass allInstances.
	newObjects := oldObjects collect: [ :e | self copyObject: e to: newClass ].

	oldObjects elementsForwardIdentityTo: newObjects copyHash: true