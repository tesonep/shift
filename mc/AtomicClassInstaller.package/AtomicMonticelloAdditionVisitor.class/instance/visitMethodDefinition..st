as yet unclassified
visitMethodDefinition: aDefinition
	(AtomicClassInstaller uniqueInstance classAt: aDefinition className)
		compile: aDefinition source
		classified: aDefinition category
		withStamp: aDefinition timeStamp
		notifying: nil
