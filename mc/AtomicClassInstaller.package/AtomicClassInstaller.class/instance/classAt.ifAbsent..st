accessing
classAt: name ifAbsent: aBlockClosure 
	changedClasses detect: [ :kv | kv key name = name ]  ifFound:[ :kv | ^ kv value ].
	newClasses detect:[:cls | cls name = name] ifFound:[:cls | ^ cls ].
	 
	^self innerClassInstaller classAt: name ifAbsent: aBlockClosure. 