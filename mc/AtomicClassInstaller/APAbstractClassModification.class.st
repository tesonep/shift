Class {
	#name : #APAbstractClassModification,
	#superclass : #APAbstractPatchOperation,
	#instVars : [
		'definedClassName',
		'superclassName',
		'slots',
		'classSlots',
		'sharedSlots',
		'sharedPools',
		'category',
		'type',
		'comment',
		'commentStamp',
		'traitComposition',
		'classTraitComposition'
	],
	#category : 'AtomicClassInstaller-AtomicPatchOperations'
}

{ #category : #'instance creation' }
APAbstractClassModification class >> basicFromClass: aClass [
	^ self basicNew
		definedClassName: aClass name;
		superclassName: (aClass superclass ifNotNil:#name);
		slots: (aClass slots collect:[:e | APSlotDefinition name: e name type: e class name]);
		sharedSlots: (aClass classPool associations collect:[:e | APSlotDefinition name: e key name type: #ClassVariable]);
		classSlots: (aClass class slots collect:[:e | APSlotDefinition name: e name type: e class name]);
		sharedPools: aClass sharedPoolsString;
		category: aClass category;
		type: aClass typeOfClass;
		comment: aClass organization comment;
		commentStamp: aClass organization commentStamp;
		traitComposition: aClass traitComposition asString;
		classTraitComposition: aClass class traitComposition asString
]

{ #category : #'instance creation' }
APAbstractClassModification class >> basicFromClassDefinition: aDefinition [
	| source |
	source := RBAddClassChange definition: aDefinition.

	^ self basicNew
		definedClassName: source changeClassName asSymbol;
		superclassName: source superclassName;
		slots: (source instanceVariableNames collect:[:e | APSlotDefinition name: e type: #InstanceVariableSlot]);
		sharedSlots: (source classVariableNames collect:[:e | APSlotDefinition name: e type: #ClassVariable]);
		classSlots: #();
		sharedPools: (source sharedPoolNames joinUsing: ' ');
		category: source category;
		type: #normal;
		comment: nil;
		commentStamp: nil;
		traitComposition: '{}';
		classTraitComposition: '{}'	
]

{ #category : #'instance creation' }
APAbstractClassModification class >> basicFromMCDefinition: mcDefinition [
	^ self basicNew
		definedClassName: mcDefinition className;
		superclassName: mcDefinition superclassName;
		slots: ((mcDefinition variables reject:#isClassVariable) collect:[:e | APSlotDefinition newInstanceVariable: e name]);
		sharedSlots: ((mcDefinition variables select:#isClassVariable) collect:[:e | APSlotDefinition newInstanceVariable: e name]);
		classSlots: ((mcDefinition variables select:#isClassInstanceVariable) collect:[:e | APSlotDefinition newInstanceVariable: e name]);
		sharedPools: mcDefinition sharedPoolsString;
		category: mcDefinition category;
		type: mcDefinition type;
		comment: mcDefinition comment;
		commentStamp: mcDefinition commentStamp;
		traitComposition: mcDefinition traitComposition;
		classTraitComposition: mcDefinition classTraitComposition
]

{ #category : #'instance creation' }
APAbstractClassModification class >> basicFromRBClass: aClass [
	^ self basicNew
		definedClassName: aClass name;
		superclassName: (aClass superclass ifNotNil:#name);
		slots: (aClass instanceVariableNames collect:[:e | APSlotDefinition name: e type: #InstanceVariableSlot]);
		sharedSlots: (aClass classVariableNames collect:[:e | APSlotDefinition name: e type: #ClassVariable]);
		classSlots: (aClass theMetaClass instanceVariableNames collect:[:e | APSlotDefinition name: e type: #InstanceVariableSlot]);
		sharedPools: (aClass sharedPoolNames joinUsing: ' ');
		category: aClass category;
		type: #normal;
		comment: aClass comment;
		commentStamp: nil;
		traitComposition: '{}';
		classTraitComposition: '{}'
]

{ #category : #'instance creation' }
APAbstractClassModification class >> empty [
	^ self basicNew
		definedClassName: '';
		superclassName: #Object;
		slots: #();
		sharedSlots:#();
		classSlots: #();
		sharedPools: '';
		category: nil;
		type: #normal;
		comment: nil;
		commentStamp: nil;
		traitComposition: '{}';
		classTraitComposition: '{}'
]

{ #category : #'instance creation' }
APAbstractClassModification class >> fromClass: aClass [
	^	(self basicFromClass: aClass)  	
		initialize;
		yourself
]

{ #category : #'instance creation' }
APAbstractClassModification class >> fromClassDefinition: aDefinition [
	^	(self basicFromClassDefinition: aDefinition)  	
		initialize;
		yourself
]

{ #category : #'instance creation' }
APAbstractClassModification class >> fromMCDefinition: mcDefinition [
	^	(self basicFromMCDefinition: mcDefinition)  	
		initialize;
		yourself
]

{ #category : #'instance creation' }
APAbstractClassModification class >> fromRBClass: aRBClass [
	^	(self basicFromRBClass: aRBClass)  	
		initialize;
		yourself
]

{ #category : #altering }
APAbstractClassModification >> addClassSlotNamed: aName [
	sharedSlots := sharedSlots copyWith: (APSlotDefinition name: aName type: #ClassVariable).

]

{ #category : #altering }
APAbstractClassModification >> addSlotNamed: aName [
	slots
		detect: [ :e | e slotName = aName asSymbol ]
		ifFound: [  ]
		ifNone: [ slots := slots copyWith: (APSlotDefinition newInstanceVariable: aName asSymbol) ]
]

{ #category : #'as yet unclassified' }
APAbstractClassModification >> apply [
	^ [ AtomicClassInstaller
		make: [ :builder | 
			| superClass |
			superClass := superclassName == #nil
				ifFalse: [ builder classNamed: superclassName ].
			
			builder
				superclass: superClass;
				name: definedClassName;
				layoutClass: (ObjectLayout layoutForType: type);
				slots: (self slotDefinitionsFor: builder);
				sharedVariables: (sharedSlots collect:#slotName);
				sharedPools: self sharedPools;
				classSlots: (self classSlotDefinitionsFor: builder);
				traitComposition: self traitCompositionCompiled;
				classTraitComposition: self classTraitCompositionCompiled;
				comment: self comment stamp: self commentStamp;
				category: self category ] ]
		on: Warning , DuplicatedVariableError
		do: [ :ex | ex resume ]
]

{ #category : #accessing }
APAbstractClassModification >> category [
	^ category
]

{ #category : #accessing }
APAbstractClassModification >> category: anObject [
	category := anObject
]

{ #category : #'as yet unclassified' }
APAbstractClassModification >> classSlotDefinitionsFor:builder [
	^ classSlots collect:[:e | e slotName asSymbol => (builder classNamed: e type asSymbol ) ]
]

{ #category : #accessing }
APAbstractClassModification >> classSlots [
	^ classSlots
]

{ #category : #accessing }
APAbstractClassModification >> classSlots: anObject [
	classSlots := anObject
]

{ #category : #accessing }
APAbstractClassModification >> classTraitComposition [
	^ classTraitComposition ifNil:['#()']
]

{ #category : #accessing }
APAbstractClassModification >> classTraitComposition: anObject [
	classTraitComposition := anObject
]

{ #category : #'as yet unclassified' }
APAbstractClassModification >> classTraitCompositionCompiled [
	^(Smalltalk compiler evaluate: self classTraitComposition) asTraitComposition
]

{ #category : #accessing }
APAbstractClassModification >> comment [
	^ comment
]

{ #category : #accessing }
APAbstractClassModification >> comment: anObject [
	comment := anObject
]

{ #category : #accessing }
APAbstractClassModification >> commentStamp [
	^ commentStamp
]

{ #category : #accessing }
APAbstractClassModification >> commentStamp: anObject [
	commentStamp := anObject
]

{ #category : #accessing }
APAbstractClassModification >> definedClassName [
	^ definedClassName
]

{ #category : #accessing }
APAbstractClassModification >> definedClassName: anObject [
	definedClassName := anObject
]

{ #category : #altering }
APAbstractClassModification >> removeClassSlotNamed: aName [
	sharedSlots := sharedSlots reject:[:e | e slotName = aName].

]

{ #category : #altering }
APAbstractClassModification >> removeSlotNamed: aName [
	slots := slots reject:[:e | e slotName = aName].

]

{ #category : #accessing }
APAbstractClassModification >> sharedPools [
	^ sharedPools
]

{ #category : #accessing }
APAbstractClassModification >> sharedPools: anObject [
	sharedPools := anObject
]

{ #category : #accessing }
APAbstractClassModification >> sharedSlots [
	^ sharedSlots
]

{ #category : #accessing }
APAbstractClassModification >> sharedSlots: anObject [
	sharedSlots := anObject
]

{ #category : #'as yet unclassified' }
APAbstractClassModification >> slotDefinitionsFor:builder [
	^ slots collect:[:e | e slotName asSymbol => (builder classNamed: e type asSymbol ) ]
]

{ #category : #accessing }
APAbstractClassModification >> slots [
	^ slots
]

{ #category : #accessing }
APAbstractClassModification >> slots: anObject [
	slots := anObject
]

{ #category : #accessing }
APAbstractClassModification >> superclassName [
	^ superclassName
]

{ #category : #accessing }
APAbstractClassModification >> superclassName: anObject [
	superclassName := anObject
]

{ #category : #accessing }
APAbstractClassModification >> traitComposition [
	^ traitComposition ifNil:['#()'].
]

{ #category : #accessing }
APAbstractClassModification >> traitComposition: anObject [
	traitComposition := anObject
]

{ #category : #'as yet unclassified' }
APAbstractClassModification >> traitCompositionCompiled [
	^(Smalltalk compiler evaluate: self traitComposition) asTraitComposition
]

{ #category : #accessing }
APAbstractClassModification >> type [
	^ type
]

{ #category : #accessing }
APAbstractClassModification >> type: anObject [
	type := anObject
]
