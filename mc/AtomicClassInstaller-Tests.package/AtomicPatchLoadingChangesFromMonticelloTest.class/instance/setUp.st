as yet unclassified
setUp
	mcRepo := MCDirectoryRepository new
		directory: self repoDirectory asFileReference;
		yourself.
	MCWorkingCopy announcer suspendAllWhile: [ (mcRepo versionFrom: 'AtomicClassInstaller-Tests-Code-PabloTesone.1') load ]