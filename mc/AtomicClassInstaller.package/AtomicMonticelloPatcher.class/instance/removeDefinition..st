visitor
removeDefinition: aDefinition
	aDefinition isOrganizationDefinition
		ifTrue: [ packageRemoves add: aDefinition ].

	aDefinition isClassDefinition 
		ifTrue: [ classRemoves add: aDefinition ].

	aDefinition isMethodDefinition 
		ifTrue: [ methodRemoves add: aDefinition ]