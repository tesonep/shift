as yet unclassified
repoDirectory
	^ Smalltalk os environment at: 'TRAVIS' ifPresent: 'testCode-Repo' ifAbsent: 'iceberg-cache/tesonep/pharo-AtomicClassInstaller/testCode-Repo'