as yet unclassified
visitClassDefinition: aDefinition
	^[AtomicClassInstaller  make: [ :builder | | superClass| 
		superClass := aDefinition superclassName == #nil ifFalse:[  builder classNamed: aDefinition superclassName ].
				
		builder
			superclass: superClass;
			name: aDefinition className;
			layoutClass: (ObjectLayout layoutForType: aDefinition type);
			slots: aDefinition instanceVariables;
			sharedVariables: aDefinition classVariables;
			sharedPools: aDefinition sharedPoolsString;
			classSlots: aDefinition classInstanceVariables;
			traitComposition: aDefinition traitCompositionCompiled;
			classTraitComposition: aDefinition classTraitCompositionCompiled;
			comment: aDefinition comment stamp: aDefinition commentStamp;
			category: aDefinition category]] on: Warning, DuplicatedVariableError do: [:ex| ex resume].
	


