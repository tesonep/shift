as yet unclassified
lookForFicusClass: aName
	^ self ficusPackage classes detect:[:e| e name = aName]