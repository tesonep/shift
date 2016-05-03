as yet unclassified
testCreationOfNewClass
	| class |
	
	class := AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #NewClass;
				superclass: (builder classNamed: #Object);
				slots: #(#a #b);
				category: 'AtomicClassInstaller-Tests' ].
	
	self assert: (Smalltalk environment hasClassNamed: #NewClass) not.				
	self assert: class methods size equals: 0.
	self assert: (Object subclasses includes: class) not.
	
	class compile: 'aSimpleMethod
			^ a.
	'.
	
	AtomicClassInstaller commit.
	
	self assert: (Object subclasses includes: class).
	self assert: (Smalltalk environment hasClassNamed: #NewClass).