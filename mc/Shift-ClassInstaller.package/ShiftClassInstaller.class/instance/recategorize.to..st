as yet unclassified
recategorize: aClass to: newCategory
	| oldCategory |
	oldCategory := aClass basicCategory.
	oldCategory == newCategory asSymbol
		ifTrue: [ ^ self ].

	builder environment organization ifNotNil: [ :e | e classify: aClass name under: newCategory ].

	SystemAnnouncer uniqueInstance class: aClass recategorizedFrom: oldCategory to: newCategory