as yet unclassified
testModificationOldClass
	| class obj1 |
	obj1 := OldClass new.
	obj1 firstVariable: 23.
	obj1 secondVariable: 17.
	
	class := AtomicClassInstaller
		make: [ :builder | 
			builder
				name: #OldClass;
				slots: #(#firstVariable #secondVariable #thirdVariable);
				category: 'AtomicClassInstaller-Tests' ].
					
	self assert: OldClass ~= class.
	self assert: OldClass methods size equals: class methods size.
	self assert: (OldClass methods allSatisfy: [ :mOld | class methods anySatisfy: [:mNew | mOld selector = mNew selector ]]).
	self assert: class superclass equals: OldClass superclass.
	self assert: obj1 class = OldClass.
	
	class compile: 'thirdVariable
			^ thirdVariable.
	'.

	class compile: 'thirdVariable:value
			thirdVariable := value.
	'.
	
	self assert: (OldClass methods noneSatisfy: [:mOld | mOld selector = #thirdVariable ]).
	self assert: (OldClass slots noneSatisfy: [:slot | slot name = #thirdVariable ]).
	self assert: (class methods anySatisfy: [:mOld | mOld selector = #thirdVariable ]).	
	self assert: (class slots anySatisfy: [:slot | slot name = #thirdVariable ]).		
	
	AtomicClassInstaller commit.

	self assert: (OldClass methods anySatisfy: [:mOld | mOld selector = #thirdVariable ]).	
	self assert: (OldClass slots anySatisfy: [:slot | slot name = #thirdVariable ]).		
			
	obj1 thirdVariable: 33. 
	self assert: obj1 thirdVariable = 33.
	
	self assert: obj1 firstVariable = 23.
	self assert:	 obj1 secondVariable = 17.