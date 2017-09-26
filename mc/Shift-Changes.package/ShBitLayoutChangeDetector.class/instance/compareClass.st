comparing
compareClass
	| oldLayout newLayout bitLayoutNames |
	oldLayout := builder oldClass classLayout class name.
	newLayout := builder layoutDefinition layoutClass.
	
	oldLayout = newLayout ifTrue:[ ^#() ].
	bitLayoutNames := BitsLayout allSubclasses collect: #name.
	
	((bitLayoutNames includes: oldLayout) or:[ bitLayoutNames includes: newLayout ])
		ifTrue:[ ^ { ShBitLayoutChanged new builder: builder; yourself. } ]
		ifFalse:[ ^#() ].