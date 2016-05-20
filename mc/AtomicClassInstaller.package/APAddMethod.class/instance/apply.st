as yet unclassified
apply
	(AtomicClassInstaller uniqueInstance classAt: modifiedClassName)
		compile: source
		classified: category
		withStamp: timeStamp
		notifying: nil