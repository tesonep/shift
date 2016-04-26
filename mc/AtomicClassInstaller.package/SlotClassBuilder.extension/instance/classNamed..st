*AtomicClassInstaller
classNamed: aName
	^ installer classAt: aName ifAbsent:[ self error: 'Class ', aName, ' not found'].  