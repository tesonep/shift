as yet unclassified
visitOrganizationDefinition: aDefinition
	 aDefinition categories do:[:e | self class package organizer checkPackageExistsOrRegister:e ]
