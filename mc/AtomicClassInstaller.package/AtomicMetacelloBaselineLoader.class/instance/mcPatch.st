accessing
mcPatch
	| operations patches mcVersions |
	mcVersions := self mcVersions.
	
	patches := mcVersions collect: [ :e | e snapshot patchRelativeToBase: e package snapshot ].
	operations := (patches flatCollect: #operations) asSortedCollection.
	^ MCPatch operations: operations