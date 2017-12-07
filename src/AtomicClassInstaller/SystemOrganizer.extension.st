Extension { #name : #SystemOrganizer }

{ #category : #'*AtomicClassInstaller' }
SystemOrganizer >> postCopy [
	categoryArray := categoryArray copy.
	categoryStops := categoryStops copy.
	elementArray := elementArray copy.
	^self.
]
