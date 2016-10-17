accessing
traitComposition
	^ traitComposition
		ifNil: [ (buildEnvironment hasClassNamed: self name)
				ifTrue: [ (buildEnvironment classNamed: self name) traitComposition ]
				ifFalse: [ '' asTraitComposition ] ]