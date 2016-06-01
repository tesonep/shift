accessing
runScript: aScriptText
	aScriptText ifNil:[^self].
	self class
		compile:
			'script 
	
							' , aScriptText.
	self script.
	self class removeSelector: #script.						
	