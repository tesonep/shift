as yet unclassified
remake: aClass
	self class update: aClass to: [ :anotherBuilder | 
		anotherBuilder fillFor: aClass.
		((oldClass isNotNil and:[ oldClass classLayout class ~= builder layoutDefinition layoutClass ]) and:[ 
			builder layoutDefinition isBits or:[oldClass classLayout isBits] ]) ifTrue:[
			anotherBuilder layoutDefinition layoutClass: builder layoutDefinition layoutClass	
		].
	]