accessing
classAt: name ifAbsent: aBlockClosure 
	newClasses detect:[:cls | cls name = name] ifFound:[:cls | ^ cls ].
	changedClasses detect: [ :kv | kv key name = name ] ifFound:[ :kv | ^ kv value ] ifNone:[ | anOldClass aNewClass |
			(name endsWith: ' classTrait') ifTrue:[ |traitName| 
				traitName := name withoutSuffix: ' classTrait'.
				anOldClass := (self classAt: traitName ifAbsent: aBlockClosure) classTrait.
			] ifFalse:[
				(self innerClassInstaller environment includesKey: name) ifFalse:[ ^ aBlockClosure value ].
				anOldClass := self innerClassInstaller environment at:name.
			]. 
			 
			aNewClass := self copyClass: anOldClass.
					
			changedClasses at: aNewClass name put: anOldClass -> aNewClass.
			changedClasses at: aNewClass class name put: anOldClass class -> aNewClass class.			
			^aNewClass.  
	].