accessing
patch
	| operations patches files mcVersions |
	files := self packages collect: [ :e | e file , repository packageExtension ].
	mcVersions := (files collect: [ :e | repository versionNameFromFileName: e ])
							collect: [ :e | repository versionFrom: e ].
	
	patches := mcVersions collect: [ :e | e snapshot patchRelativeToBase: e package snapshot ].
	operations := (patches flatCollect: #operations) asSortedCollection.
	^ MCPatch operations: operations