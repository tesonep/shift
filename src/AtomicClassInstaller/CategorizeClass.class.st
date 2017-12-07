Class {
	#name : #CategorizeClass,
	#superclass : #AtomicClassInstallerOperation,
	#instVars : [
		'modifiedClass',
		'oldCategory',
		'newCategory',
		'newPackage',
		'tag',
		'oldPackage'
	],
	#category : 'AtomicClassInstaller-Operations'
}

{ #category : #'as yet unclassified' }
CategorizeClass class >> for: installer class: class newCategory: newCategory [ 
	^ self for:installer class:class oldCategory: nil newCategory: newCategory.
]

{ #category : #'as yet unclassified' }
CategorizeClass class >> for: installer class: class oldCategory: oldCategory newCategory: newCategory [ 
	| op |
	op := self basicNew
				installer: installer;
				modifiedClass: class;
				oldCategory: oldCategory;
				newCategory: newCategory;
				initialize;
				yourself.
				
	installer addOperation: op.
	^op.
]

{ #category : #actions }
CategorizeClass >> classifyInRPackage [
	self oldPackage = self newPackage
		ifTrue: [ self newPackage importClass: modifiedClass inTag: self tag ]
		ifFalse: [ self newPackage moveClass: modifiedClass fromPackage: self oldPackage toTag: self tag ].
	self packageOrganizer registerPackage: self newPackage forClass: modifiedClass.
	SystemOrganization classify: modifiedClass name under: newCategory.
]

{ #category : #actions }
CategorizeClass >> doImpact [	
	self classifyInRPackage.	

	self assert:[ self newPackage includesClass: modifiedClass ]. 
	self assert:[ (self packageOrganizer packageOf: modifiedClass) == self newPackage ]. 
		
	^ self.
]

{ #category : #actions }
CategorizeClass >> impact [
	| oldOrganizer |
	oldOrganizer := SystemOrganization.
	Smalltalk at: #SystemOrganization put: installer newOrganizer.
	[ self doImpact ]
		ensure: [ Smalltalk at: #SystemOrganization put: oldOrganizer ]
]

{ #category : #accessing }
CategorizeClass >> modifiedClass [
	^ modifiedClass
]

{ #category : #accessing }
CategorizeClass >> modifiedClass: anObject [
	modifiedClass := anObject
]

{ #category : #accessing }
CategorizeClass >> newCategory [
	^ newCategory
]

{ #category : #accessing }
CategorizeClass >> newCategory: anObject [
	newCategory := anObject
]

{ #category : #accessing }
CategorizeClass >> newPackage [
	^ newPackage
		ifNil: [ 
			newPackage := (self packageOrganizer packageMatchingExtensionName: newCategory)
				ifNil: [ self packageOrganizer registerPackage: (RPackage named: newCategory) ] ]
]

{ #category : #accessing }
CategorizeClass >> oldCategory [
	^ oldCategory
]

{ #category : #accessing }
CategorizeClass >> oldCategory: anObject [
	oldCategory := anObject
]

{ #category : #accessing }
CategorizeClass >> oldPackage [
	^ oldPackage
		ifNil: [ oldPackage := self packageOrganizer packageOf: modifiedClass  ]
]

{ #category : #accessing }
CategorizeClass >> packageOrganizer [
	^ self installer packageOrganizer.
]

{ #category : #accessing }
CategorizeClass >> tag [
	| tagName |
	^ tag
		ifNil: [ tagName := self newPackage toTagName: newCategory.
			tag := self newPackage classTagNamed: tagName ifAbsent: [ self newPackage basicAddClassTag: tagName ] ]
]
