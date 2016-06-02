as yet unclassified
migrateInstance: new from: old
	^ self block cull: new  cull: old cull:self 	