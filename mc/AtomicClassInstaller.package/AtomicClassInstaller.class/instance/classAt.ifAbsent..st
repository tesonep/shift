accessing
classAt: aString ifAbsent: aBlockClosure 
	^self innerClassInstaller classAt: aString ifAbsent: aBlockClosure. 