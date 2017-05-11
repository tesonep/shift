as yet unclassified
recategorize: aClass to: newCategory builder: builder
	| oldCategory |
	oldCategory := aClass basicCategory.
	oldCategory == newCategory asSymbol
		ifTrue: [ ^ self ].

	builder environment organization ifNotNil: [ :e | e classify: aClass name under: newCategory ].

	oldCategory
		ifNil: [ SystemAnnouncer uniqueInstance classAdded: aClass inCategory: newCategory ]
		ifNotNil: [ SystemAnnouncer uniqueInstance class: aClass recategorizedFrom: oldCategory to: newCategory ]