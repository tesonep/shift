Class {
	#name : #AbstractAtomicPatchTest,
	#superclass : #AbstractAtomicInstallerTest,
	#category : 'AtomicClassInstaller-Tests'
}

{ #category : #'as yet unclassified' }
AbstractAtomicPatchTest >> createAddClass: aClassName slots: slots [
	^ APCreateClass new
		definedClassName: aClassName;
		superclassName: #Object;
		slots: (slots collect: [ :e | APSlotDefinition newInstanceVariable: e ]);
		sharedSlots: #();
		classSlots: #();
		sharedPools: '';
		category: 'AtomicClassInstaller-Tests';
		type: #normal;
		comment: nil;
		commentStamp: nil;
		traitComposition: '{}';
		classTraitComposition: '{}'
]

{ #category : #'as yet unclassified' }
AbstractAtomicPatchTest >> createAddMethod: selector on: className source: source [
	^APAddMethod basicNew
		isMeta: false;
		source: source;
		category: #'as yet unclassified';
		selector: selector;
		modifiedClassName: className;
		timeStamp: 'xxx';
		initialize;
		yourself
]

{ #category : #'as yet unclassified' }
AbstractAtomicPatchTest >> createModifyClass: aClassName slots: slots from: originalDefinition [
	^ APModifyClass new
		definedClassName: aClassName;
		superclassName: #Object;
		slots: (slots collect: [ :e | APSlotDefinition newInstanceVariable: e ]);
		sharedSlots: #();
		classSlots: #();
		sharedPools: '';
		category: 'AtomicClassInstaller-Tests';
		type: #normal;
		comment: nil;
		commentStamp: nil;
		traitComposition: '{}';
		classTraitComposition: '{}';
		originalClassDefinition: originalDefinition
]
