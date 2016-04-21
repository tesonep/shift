notifications
addSubclass: class to: superclass
	changedSubclassArray
		at: superclass name
		ifPresent: [ :kv | kv value: (kv value copyWith: class) ]
		ifAbsent: [ changedSubclassArray
				at: superclass name
				put: superclass -> (superclass subclasses copyWith: class) ]