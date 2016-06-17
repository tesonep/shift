tests
testMigratingClassVariable
	| class |
	self classWithClassVariable classVariable: 23.

	class := AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #ClassWithClassVariable;
				traitComposition: {};
				slots: #();
				classSlots: #(classVariable otherClassVariable);
				category: 'AtomicClassInstaller-Tests'.
				].
			
	class class compile:'otherClassVariable 
		^ otherClassVariable
	'.

	class class compile:'otherClassVariable:aValue 
		otherClassVariable := aValue
	'.

	self assertNonAnnouncements.		
	AtomicClassInstaller commit.
	
	self classWithClassVariable perform: #otherClassVariable: with: 42. 
	
	self assert: ((self classWithClassVariable perform:#classVariable) = 23).
	self assert: ((self classWithClassVariable perform:#otherClassVariable) = 42)