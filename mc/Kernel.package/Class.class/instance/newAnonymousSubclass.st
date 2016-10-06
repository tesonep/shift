subclass creation
newAnonymousSubclass
	^ Smalltalk anonymousClassInstaller make: [ :builder |
		builder
			superclass: self ;
			layoutClass: self classLayout class ].
