as yet unclassified
validateClassName
	name ifNil: [ ^self ].
	
	name isSymbol ifFalse:[InvalidGlobalName 
				signal: 'Global names should be symbols' 
				for: name].

	name isValidGlobalName ifFalse: [ 
		InvalidGlobalName signal: 'Class name is not a valid global name. It must start with uppercase letter and continue with alphanumeric characters or underscore. Default names used in class or trait templates are not allowed.' for: name  ].
	
		
	DangerousClassNotifier check: name 