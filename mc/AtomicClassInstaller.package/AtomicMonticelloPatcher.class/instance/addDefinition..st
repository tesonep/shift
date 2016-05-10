visitor
addDefinition: aDefinition
	aDefinition isOrganizationDefinition
		ifTrue: [ packageAdditions add: aDefinition ].

	aDefinition isClassDefinition 
		ifTrue: [ classAdditions add: aDefinition ].

	aDefinition isMethodDefinition 
		ifTrue: [ methodAdditions add: aDefinition ]