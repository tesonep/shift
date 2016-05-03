accessing
copyClass: oldClassOrTrait
	^ oldClassOrTrait isTrait
		ifTrue: [ oldClassOrTrait copy ]
		ifFalse: [ self doCopyClass: oldClassOrTrait ]