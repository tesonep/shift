as yet unclassified
oldClass: anObject
	oldClass := anObject.
	oldClass ifNotNil: [oldMetaclass := oldClass class].