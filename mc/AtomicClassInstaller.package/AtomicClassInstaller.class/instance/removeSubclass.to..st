notifications
removeSubclass: class to: superclass
	changedSubclassArray
		at: superclass name
		ifPresent: [ :kv | kv value: (kv value copyWithout: class) ]
		ifAbsent: [ changedSubclassArray
				at: superclass name
				put: superclass -> (superclass subclasses copyWithout: class) ]