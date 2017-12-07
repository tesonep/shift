"
This implementation of the class installer provides a way of performing all the operations atomically. 
The way it is performed is creating all the objects and meta objects in a paralell hierarchy and then 
it performs a bulk replace of all the objects and meta-objects.

It is used in the same way as the other ClassInstallers, through the use of AtomicClassInstaller class >> #make:

The ClassInstaller can be configured in auto commit mode, by the use of AtomicClassInstaller class >> autocommit, and 
AtomicClassInstaller class >> autocommit: 

If the autocommit is in true the behavior will be the same as the one expected in a normal ClassInstaller, making the modifications available 
as soon as they are performed. 

If the autocommit is in false, the commit operation should be triggered through the use of AtomicClassInstaller class >> commit.


"
Class {
	#name : #AtomicClassInstaller,
	#superclass : #AbstractClassInstaller,
	#instVars : [
		'innerClassInstaller',
		'changedClasses',
		'newClasses',
		'changedSubclassArray',
		'newEnvironment',
		'oldObjects',
		'newObjects',
		'objectsToMigrate',
		'operations',
		'oldOrganizer',
		'newOrganizer',
		'objectMigratorProvider',
		'alreadyCommited',
		'newRPackageOrganizer',
		'oldRPackageOrganizer',
		'storedAnnouncements',
		'removedClasses'
	],
	#classVars : [
		'AssertActive',
		'Autocommit'
	],
	#classInstVars : [
		'uniqueInstance'
	],
	#category : 'AtomicClassInstaller'
}

{ #category : #'as yet unclassified' }
AtomicClassInstaller class >> autocommit [
	^ Autocommit ifNil:[ Autocommit := true].
]

{ #category : #'as yet unclassified' }
AtomicClassInstaller class >> autocommit: aValue [
	Autocommit := aValue.
]

{ #category : #'as yet unclassified' }
AtomicClassInstaller class >> commit [
	self uniqueInstance commit.
	self reset.
]

{ #category : #'as yet unclassified' }
AtomicClassInstaller class >> isAssertActive [ 
	^ AssertActive ifNil:[AssertActive := true].
]

{ #category : #'as yet unclassified' }
AtomicClassInstaller class >> make: aBlock [
	| builder result announcements |
	Autocommit ifNil: [ Autocommit := true ].
	self autocommit ifTrue: [ self reset ].
	
	self uniqueInstance storedAnnouncements addAll:(SystemAnnouncer uniqueInstance
		suspendAllWhileStoring: [ 
			builder := self uniqueInstance builder.
			aBlock value: builder.
			result := builder build 
		]).
	
	self autocommit ifTrue: [ self commit ].
	^ result
]

{ #category : #'as yet unclassified' }
AtomicClassInstaller class >> new [
	^ self error: 'Should use #uniqueInstance'
]

{ #category : #removing }
AtomicClassInstaller class >> removeClass: aClass [
	Autocommit ifNil: [ Autocommit := true ].
	self autocommit ifTrue: [ self reset ].
	
	self uniqueInstance removeClass: aClass.
	
	self autocommit ifTrue: [ self commit ].
	
]

{ #category : #'as yet unclassified' }
AtomicClassInstaller class >> reset [ 
	uniqueInstance := nil.
]

{ #category : #'as yet unclassified' }
AtomicClassInstaller class >> rollback [
	self reset.
]

{ #category : #'as yet unclassified' }
AtomicClassInstaller class >> uniqueInstance [
	^ uniqueInstance ifNil:[ uniqueInstance := self basicNew initialize; yourself.]
]

{ #category : #operations }
AtomicClassInstaller >> addOperation: anOperation [
	operations add:anOperation.
]

{ #category : #asserting }
AtomicClassInstaller >> assert: aValuable [
	self isAssertActive
		ifTrue: [ ^ super assert: aValuable ]
]

{ #category : #accessing }
AtomicClassInstaller >> atEnvironment: aName put: aValue [
	| newAssoc oldAssoc |
	newAssoc := newEnvironment
		associationAt: aName
		ifAbsent: [ newEnvironment at: aName put: aValue.
			^ aValue ].

	oldAssoc := Smalltalk globals associationAt: aName.

	newAssoc ~~ oldAssoc
		ifTrue: [ ^ newEnvironment at: aName put: aValue ]
		ifFalse: [ newEnvironment removeKey: aName.
			newEnvironment at: aName put: aValue.
			self assert: [(newEnvironment associationAt: aName) ~~ oldAssoc].
			^ aValue ]
]

{ #category : #accessing }
AtomicClassInstaller >> basicClassAt: name ifFound: aBlockFound ifAbsent: aBlockAbsent [
	newClasses detect: [ :cls | cls name = name ] ifFound: aBlockFound.
	changedClasses
		detect: [ :kv | kv key name = name ]
		ifFound: [ :kv | aBlockFound value: kv value ]
		ifNone: aBlockAbsent
]

{ #category : #notifications }
AtomicClassInstaller >> basicClassDefinitionChangedFrom: oldClass to: newClass using: classModification [ 
	" Copy over the trait composition "
	self copyTraitCompositionFrom: oldClass to: newClass.		
	" Copy over the method organization "
	newClass organization: oldClass organization.

	"Handle subclass changes"
	oldClass superclass == newClass superclass ifFalse: [ 
		self superclassChangedFrom:oldClass to: newClass by: classModification.
	].
	"Handle the changes in the layout"
	self updateLayoutInSubClassesFrom: oldClass to:newClass.
]

{ #category : #notifications }
AtomicClassInstaller >> classAdded: aClass inCategory: aString [ 
	newClasses add: aClass.
	aClass basicCategory: aString.
	self atEnvironment: aClass name put: aClass.
	
	AddSubclass for: self class: aClass superclass: aClass superclass.
	CategorizeClass for: self class: aClass newCategory: aString asSymbol.
]

{ #category : #accessing }
AtomicClassInstaller >> classAt: aName [
	^self classAt: aName ifAbsent: [ self error: 'Unknown class ', aName ]. 
]

{ #category : #accessing }
AtomicClassInstaller >> classAt: name ifAbsent: aBlockClosure [ 
	self basicClassAt: name ifFound:[:cls | ^ cls ] ifAbsent:[ | anOldClass aNewClass |
			(name endsWith: ' classTrait') ifTrue:[ |traitName| 
				traitName := name withoutSuffix: ' classTrait'.
				anOldClass := (self classAt: traitName ifAbsent: aBlockClosure) classTrait.
			] ifFalse:[
				(self innerClassInstaller environment includesKey: name) ifFalse:[ ^ aBlockClosure value ].
				anOldClass := self innerClassInstaller environment at:name.
			]. 
			 
			aNewClass := self copyClass: anOldClass.
			
			self assert:[aNewClass class allInstances includes: aNewClass].
						
			^aNewClass.  
	].
]

{ #category : #notifications }
AtomicClassInstaller >> classDefinitionChangedFrom: oldClass to: newClass by: classModification [		
	changedClasses at: newClass name put: (changedClasses at: newClass name) key -> newClass.

	newClass isMeta
		ifTrue: [ changedClasses at: newClass baseClass name put: (changedClasses at: newClass baseClass name) key -> newClass baseClass ]
		ifFalse: [ changedClasses at: newClass class name put: (changedClasses at: newClass class name) key -> newClass class ].
	
	newClass isMeta ifTrue:[self migrateMetaObjects: oldClass to: newClass ].
	
	newClass isMeta ifFalse:[ self atEnvironment:newClass name put: newClass ].
	
	self
		copyMethodsFrom: oldClass to: newClass using: classModification;
		basicClassDefinitionChangedFrom: oldClass to: newClass using: classModification.
]

{ #category : #accessing }
AtomicClassInstaller >> classNamed: aName [
	"Returns the class if its modified, the modified one if not the one in the internal installer"
	^ self basicClassAt: aName ifFound:[:c | ^ c]  ifAbsent:[^ innerClassInstaller classNamed: aName] 
]

{ #category : #actions }
AtomicClassInstaller >> commit [
	self storedAnnouncements
		addAll: (SystemAnnouncer uniqueInstance suspendAllWhileStoring: [ self doCommit ]).
	
	self storedAnnouncements do:[:ann | SystemAnnouncer uniqueInstance announce: ann].
	self storedAnnouncements removeAll.
]

{ #category : #utils }
AtomicClassInstaller >> copyClass: oldClassOrTrait [
	^ oldClassOrTrait isTrait
		ifTrue: [ self doCopyTrait: oldClassOrTrait ]
		ifFalse: [ self doCopyClass: oldClassOrTrait ]
]

{ #category : #utils }
AtomicClassInstaller >> copyLayoutFrom: oldClass to: newClass [
	| newLayout superclassName parentSlotScope |
	newLayout := oldClass classLayout copy host: newClass.
	superclassName := newClass superclass name.
	newLayout slotScope hasParent
		ifTrue: [ self
				basicClassAt: superclassName
				ifFound: [ :c | parentSlotScope := c classLayout slotScope ]
				ifAbsent: [ parentSlotScope := (self innerClassInstaller
						classAt: superclassName
						ifAbsent: [ self error: 'Could not found superclass ' , superclassName ])
						classLayout slotScope ].
			newLayout slotScope parentScope: parentSlotScope ].
	newClass classLayout: newLayout
]

{ #category : #copying }
AtomicClassInstaller >> copyMethodsFrom: oldClass to: newClass using: classModification [ 
	newClass compileAllFrom: oldClass.
]

{ #category : #traits }
AtomicClassInstaller >> copyTraitCompositionFrom: oldClass to: newClass [

(oldClass traitComposition syntacticallyEquals: newClass traitComposition )ifTrue:[^ self ].
	self 
		installTraitComposition: oldClass traitComposition copyTraitExpression 
		on: newClass.

]

{ #category : #asserting }
AtomicClassInstaller >> doAsserts [
	self assert:[changedClasses values allSatisfy: [:kv | kv key == kv value ]].
	self assert:[Smalltalk garbageCollect. (changedClasses values collect:#key thenSelect:#isMeta) allSatisfy: [:e | e allInstances size = 1]].
	self assert:[(IdentitySet allSubInstances reject: #isHealthy) isEmpty ].
]

{ #category : #actions }
AtomicClassInstaller >> doCommit [	
	alreadyCommited ifTrue:[ self error:'It should have been reseted'].

	oldObjects := OrderedCollection new.
	newObjects := OrderedCollection new.
	objectsToMigrate := OrderedCollection new.
	
	[ 
		alreadyCommited := true.
		oldOrganizer := Smalltalk globals organization.
		newOrganizer := oldOrganizer copy.
		newOrganizer environment: newEnvironment.
	
		operations do:#impact.
		operations removeAll.

		changedClasses valuesDo: [ :a | |newClass oldClass|
			newClass := a value.
			oldClass := a key.
			
			oldObjects add: oldClass. 
			newObjects add: newClass.
						
			"I have to migrate the associations, so they are shared".
			newClass isMeta ifFalse:[
				newClass classPool associationsDo: [ :newAssoc |
					oldClass classPool associationAt: newAssoc key ifPresent: [ :oldAssoc | (newAssoc == oldAssoc) ifFalse:[oldObjects add: oldAssoc. newObjects add: newAssoc]]
				]
			].
			
			objectsToMigrate addAll:(self migrateObjectsFrom: a key to: a value). 
		 ].

		objectsToMigrate do:[ :a | 
			oldObjects add: a key. 
			newObjects add: a value.
		].
				
		oldObjects add:Smalltalk globals.
		newObjects add:newEnvironment.

		newEnvironment associationsDo:[:newAssoc | 
			Smalltalk globals	associationAt: newAssoc key ifPresent:[:oldAssoc | 
						(oldAssoc ~~ newAssoc) ifTrue:[
							oldObjects add:oldAssoc.
							newObjects add:newAssoc.
						]
				] 
		].

		oldObjects add:oldRPackageOrganizer.
		newObjects add:newRPackageOrganizer.

		oldObjects add:oldOrganizer.
		newObjects add:newOrganizer.
		
		oldObjects with:newObjects do:[ :a :b | self assert:[( a == b ) not]].
		self assert: [oldObjects allSatisfy: #isNotNil] .
		self assert: [newObjects allSatisfy: #isNotNil] .

		self assert: [oldObjects noneSatisfy: [:e | e class = SmallInteger]] .
		self assert: [newObjects noneSatisfy: [:e | e class = SmallInteger]] .
							
		CompiledMethod allInstancesDo: #flushCache.
				
		oldObjects asArray elementsForwardIdentityTo: newObjects asArray copyHash: true.

		removedClasses do: [ :e | e removeFromSystem ].
		 		
	] valueUnpreemptively.

self doAsserts.

changedClasses removeAll.
newClasses removeAll.
objectsToMigrate removeAll.

]

{ #category : #utils }
AtomicClassInstaller >> doCopyClass: oldClass [
	| newClass |

	newClass := oldClass class copy new
		superclass: oldClass superclass;
		methodDict: oldClass methodDict copy;
		setFormat: oldClass format;
		setName: oldClass name;
		organization: oldClass organization copy;
		classPool: oldClass classPool copy;
		sharedPools: oldClass sharedPools copy.
		
	changedClasses at: newClass name put: oldClass -> newClass.
	changedClasses at: newClass class name put: oldClass class -> newClass class.			
		
	oldClass class instSize+1 to: oldClass class instSize do:
		[:offset | newClass instVarAt: offset put: (oldClass instVarAt: offset)].
	
	oldClass class allSlots do:[ :slot | slot write: (slot read:oldClass) to: newClass ].
	
	self copyLayoutFrom: oldClass to:newClass.
	
	newClass basicCategory: oldClass basicCategory.
	newClass environment: oldClass environment.
	newClass traitComposition: oldClass traitComposition.
	newClass subclasses: (oldClass subclasses collect:[:sc | self classAt: sc name. ]).
	newClass localSelectors: oldClass basicLocalSelectors copy.
	self updateLayoutInSubClassesFrom: oldClass to:newClass.
	
	^ newClass.
]

{ #category : #utils }
AtomicClassInstaller >> doCopyTrait: oldTrait [
	| newTrait |
	newTrait := oldTrait copy.
	changedClasses at: newTrait name put: oldTrait -> newTrait.
	changedClasses at: newTrait class name put: oldTrait class -> newTrait class.			
	^ newTrait

]

{ #category : #accessing }
AtomicClassInstaller >> environment [
	^ newEnvironment.
]

{ #category : #accessing }
AtomicClassInstaller >> environment: aValue [

]

{ #category : #operations }
AtomicClassInstaller >> getChangedPair: aName [
	"Returns the old version and new version of a Class / Trait, if there is one"
	changedClasses at:aName ifPresent:[:e | ^ e].
	newClasses detect:[:e | e name = aName] ifFound:[:e | ^ e].
	^ nil. 	
]

{ #category : #initialization }
AtomicClassInstaller >> initialize [
	super initialize.
	innerClassInstaller := PharoClassInstaller new.
	changedClasses := Dictionary new.
	newClasses := OrderedCollection new.
	operations := OrderedCollection new.
	alreadyCommited := false.
	storedAnnouncements := OrderedCollection new.
	removedClasses := OrderedCollection new.
	
	objectMigratorProvider := ACIDefaultObjectMigratorProvider new.
	
	oldRPackageOrganizer := self class packageOrganizer.
	newRPackageOrganizer := self class packageOrganizer copy.

" I initialize the newEnvironment with the same associations (identicals), after if we changed them a new one is put in the new environment."
	newEnvironment := Smalltalk globals shallowCopy. 
	newEnvironment instVarNamed: #array  put: (newEnvironment array) copy.

]

{ #category : #accessing }
AtomicClassInstaller >> innerClassInstaller [
	^ innerClassInstaller
]

{ #category : #traits }
AtomicClassInstaller >> installTraitComposition: aTraitComposition on: aClass [
	
	(aClass hasTraitComposition not and: [aTraitComposition isEmpty]) ifTrue: [^self].
	aTraitComposition assertValidUser: aClass.

	InstallTraitComposition for: self class: aClass trait: aTraitComposition. 

	aClass traitComposition traits do: [:each | RemoveUserOfTrait for:self class: aClass trait: each].
	aTraitComposition traits do: [:each | AddUserOfTrait for:self class: aClass trait: each]

]

{ #category : #asserting }
AtomicClassInstaller >> isAssertActive [
	^ self class isAssertActive.
]

{ #category : #accessing }
AtomicClassInstaller >> isChangedClass: aClass [
	^ (changedClasses at:aClass name) value == aClass.
]

{ #category : #migrating }
AtomicClassInstaller >> migrateChangedClassFrom: oldClass to:newClass [
	| original |
	"This migration is only occured when an already changed class is changed, we are modifying the copies of the system. 
	The already changed class is different than the one in the old part of the changed class collection"

	original := (changedClasses at:newClass name) key.
	
	original ~~ oldClass ifTrue:[
		{ oldClass. oldClass class } elementsForwardIdentityTo: { newClass. newClass class } copyHash: true.		
	].	

]

{ #category : #migrating }
AtomicClassInstaller >> migrateClasses: aCollectionOfOldClasses to: aCollectionOfNewClasses using: anInstanceModification [
	self assert: [ changedClasses keys includesAll: (aCollectionOfOldClasses collect: #name) ].
	aCollectionOfOldClasses with: aCollectionOfNewClasses do: [ :old :new | self migrateChangedClassFrom: old to: new ].
	
	self assert:[((changedClasses values select:[:e | e key isMeta]) allSatisfy:[:e | e key allInstances size = 1] )].

]

{ #category : #migrating }
AtomicClassInstaller >> migrateMetaObjects: oldClass to: newClass [
	| oldInstances variable instSize newInstances result |
	
	oldInstances := oldClass allInstances.
	newInstances := newClass allInstances.
		 	
	oldInstances isEmpty ifTrue: [ ^ #() ].	"no instances to convert"
			
	variable := newClass isVariable.
	instSize := newClass instSize.	
	
	(((variable = oldClass isVariable) and:[ instSize = oldClass instSize ]) 
		and:[ oldClass slots = newClass slots ]) ifTrue:[^self].
			
	result := Array new: oldInstances size.
	
	1 to: oldInstances size do: [ :i | | old new | 
		old := oldInstances at: i.
		new := newClass newInstanceFrom: (oldInstances at: i) variable: variable size: instSize.
		result at: i put: new 
	].	
	
	oldInstances elementsForwardIdentityTo: result copyHash:true. 

]

{ #category : #migrating }
AtomicClassInstaller >> migrateObjectsFrom: oldClass to: newClass [
	| oldInstances migrator |
	oldClass isTrait
		ifTrue: [ ^ #() ].
	newClass isMeta
		ifTrue: [ ^ #() ].

	((newClass isVariable = oldClass isVariable) and:[ (newClass instSize = oldClass instSize) 
		and:[ oldClass slots = newClass slots ]]) ifTrue:[^#()].	

	oldInstances := oldClass allInstances asArray.

	oldInstances isEmpty
		ifTrue: [ ^ #() ].	"no instances to convert"

	migrator := objectMigratorProvider objectMigratorFor: oldClass to: newClass.

	^ oldInstances
		collect: [ :old | old -> (self migrateSingleObject: old from: oldClass to: newClass using: migrator) ]
]

{ #category : #migrating }
AtomicClassInstaller >> migrateSingleObject: old from: oldClass to: newClass using: objectMigrator [
	| new |
	newClass isVariable
		ifTrue: [ new := newClass basicNew: old basicSize ]
		ifFalse: [ new := newClass basicNew ].

	^ objectMigrator migrateInstance: new fromOldInstance:old inNewEnv: newEnvironment fromOldEnv: self oldEnvironment.
]

{ #category : #operations }
AtomicClassInstaller >> newObjectFor: anOldObject [
	"Returns an object if the object is already in the pair of Old / New objects, the collections 
	  to be becomed."
	| idx |
	idx := oldObjects indexOf: anOldObject ifAbsent:[^nil]. 
	^ newObjects at:idx.
]

{ #category : #accessing }
AtomicClassInstaller >> newOrganizer [
	^ newOrganizer
]

{ #category : #accessing }
AtomicClassInstaller >> objectMigratorProvider [
	^ objectMigratorProvider
]

{ #category : #accessing }
AtomicClassInstaller >> objectMigratorProvider: anObject [
	objectMigratorProvider := anObject
]

{ #category : #operations }
AtomicClassInstaller >> oldEnvironment [
	^ Smalltalk globals
]

{ #category : #accessing }
AtomicClassInstaller >> packageOrganizer [
	^ newRPackageOrganizer 
]

{ #category : #notifications }
AtomicClassInstaller >> recategorize: newClass to: category [
	| oldCategory |
	oldCategory := newClass category.
	newClass basicCategory: category.
	
	CategorizeClass
		for: self
		class: newClass
		oldCategory: oldCategory
		newCategory: category asSymbol
]

{ #category : #operations }
AtomicClassInstaller >> removeClass: aClass [
	removedClasses add: aClass.
]

{ #category : #notifications }
AtomicClassInstaller >> removeSubclass: class to: superclass [
	(self classAt: superclass name) removeSubclass: class.
	(self classAt: superclass name) removeSubclass: (changedClasses at: class name) key. 
]

{ #category : #utils }
AtomicClassInstaller >> replaceSlotScope: oldSlotScope to: newSlotScope on: aClass [
	| slotScope |
	slotScope := aClass classLayout slotScope.
	slotScope hasParent
		ifTrue: [ slotScope parentScope: newSlotScope ]
]

{ #category : #notifications }
AtomicClassInstaller >> sharedVariableOrSharedPoolChangedFrom: oldClass to: newClass by: classModification [ 
	self
		classDefinitionChangedFrom: oldClass 
		to: newClass 
		by: classModification	
]

{ #category : #notifications }
AtomicClassInstaller >> slotsChangedFrom: oldClass to: newClass by: classModification [ 
	self
		classDefinitionChangedFrom: oldClass 
		to: newClass 
		by: classModification	
]

{ #category : #operations }
AtomicClassInstaller >> storeOldObject: oldObject newObject: newObject [
	| idx |
	"Adds or updates a new object to be becomed, based in the old object."
	
	idx := oldObjects
		indexOf: oldObject
		ifAbsent: [ oldObjects add: oldObject.
			newObjects add: newObject.
			self assert: [oldObjects size = newObjects size].
			^ self
			].
	newObjects at: idx put: newObject
]

{ #category : #asserting }
AtomicClassInstaller >> storedAnnouncements [
	^ storedAnnouncements
]

{ #category : #notifications }
AtomicClassInstaller >> superclassChangedFrom: oldClass to: newClass by: classModification [ 
	AddSubclass for:self class: newClass superclass: newClass superclass.
	RemoveSubclass for:self class: newClass superclass: oldClass superclass.
	

]

{ #category : #utils }
AtomicClassInstaller >> updateLayoutInSubClassesFrom: oldClass to: newClass [
	| oldSlotScope newSlotScope |
	oldSlotScope := oldClass classLayout slotScope.
	newSlotScope := newClass classLayout slotScope.
	newClass
		subclassesDo: [ :e | 
			self assert: [ self isChangedClass: e ].
			self replaceSlotScope: oldSlotScope to: newSlotScope on: e.
			self
				assert: [ e classLayout checkIntegrity.
					true ] ]
]
