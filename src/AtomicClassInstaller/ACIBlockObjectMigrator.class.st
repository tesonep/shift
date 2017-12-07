Class {
	#name : #ACIBlockObjectMigrator,
	#superclass : #ACIDefaultObjectMigrator,
	#instVars : [
		'blockCode',
		'block',
		'newEnvironment',
		'oldEnvironment'
	],
	#category : 'AtomicClassInstaller-Migrators'
}

{ #category : #'as yet unclassified' }
ACIBlockObjectMigrator >> assert: aValuable [
	AtomicClassInstaller isAssertActive
		ifTrue: [ ^ super assert: aValuable ]
]

{ #category : #'as yet unclassified' }
ACIBlockObjectMigrator >> block [
	^ block ifNil:[ self compileBlock ]
]

{ #category : #accessing }
ACIBlockObjectMigrator >> block: anObject [
	block := anObject
]

{ #category : #accessing }
ACIBlockObjectMigrator >> blockCode [
	^ blockCode
]

{ #category : #accessing }
ACIBlockObjectMigrator >> blockCode: anObject [
	blockCode := anObject
]

{ #category : #'as yet unclassified' }
ACIBlockObjectMigrator >> compileBlock [
	block := self class compiler evaluate: blockCode.
	self assert: [block isBlock].
	^block.
]

{ #category : #'as yet unclassified' }
ACIBlockObjectMigrator >> migrateInstance: new fromOldInstance:old inNewEnv:newEnv fromOldEnv:oldEnv [
	newEnvironment := newEnv.
	oldEnvironment := oldEnv.

	^ self block cull: new  cull: old cull: self.
]

{ #category : #accessing }
ACIBlockObjectMigrator >> newEnvironment [
	^ newEnvironment
]

{ #category : #accessing }
ACIBlockObjectMigrator >> newEnvironment: anObject [
	newEnvironment := anObject
]

{ #category : #accessing }
ACIBlockObjectMigrator >> oldEnvironment [
	^ oldEnvironment
]

{ #category : #accessing }
ACIBlockObjectMigrator >> oldEnvironment: anObject [
	oldEnvironment := anObject
]
