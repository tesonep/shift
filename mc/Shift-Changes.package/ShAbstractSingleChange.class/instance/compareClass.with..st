comparing
compareClass: oldClass with: builder
	oldValue := classAccessor value: oldClass.
	newValue := builderAccessor value: oldClass.

	^ (comparer value: oldValue value: newValue)
		ifTrue: [ #() ]
		ifFalse: [ {self} ]