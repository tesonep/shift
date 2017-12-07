Extension { #name : #PharoClassInstaller }

{ #category : #'*AtomicClassInstaller' }
PharoClassInstaller >> classNamed: aName [
	^self classAt:aName ifAbsent: [ self error:'Class not found:' , aName ]
]
