as yet unclassified
setUp
	AtomicClassInstaller reset.
	(Smalltalk environment hasClassNamed:#NewClass) ifTrue: [ 
		(Smalltalk environment at:#NewClass) removeFromSystem.
	]