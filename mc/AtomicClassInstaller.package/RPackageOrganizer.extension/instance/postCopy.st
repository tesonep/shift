*AtomicClassInstaller
postCopy
	packages := packages collect: [ :p | p copy ].
	classExtendingPackagesMapping := classExtendingPackagesMapping collect: [ :x | x collect: [ :e | packages at: e name ] ].
	classPackageMapping := classPackageMapping collect: [ :e | packages at: e name  ].