Class {
	#name : #AtomicMonticelloPatchConversor,
	#superclass : #Object,
	#instVars : [
		'patch',
		'additionVisitor',
		'removeVisitor',
		'modifyVisitor'
	],
	#category : 'AtomicClassInstaller-Monticello'
}

{ #category : #'as yet unclassified' }
AtomicMonticelloPatchConversor class >> convertFromMCPatch: mcPatch [
	^ self new convertFrom: mcPatch
]

{ #category : #'as yet unclassified' }
AtomicMonticelloPatchConversor class >> convertFromMCVersions: mcVersions [
	^ self new convertFrom: (MCPatch fromVersions: mcVersions)
]

{ #category : #visitor }
AtomicMonticelloPatchConversor >> addDefinition: aDefinition [
	aDefinition accept: additionVisitor .
]

{ #category : #visitor }
AtomicMonticelloPatchConversor >> convertFrom: aMCPatch [
	aMCPatch applyTo: self.
	^ patch
]

{ #category : #initialization }
AtomicMonticelloPatchConversor >> initialize [
	super initialize.
	patch := AtomicPatch new.

	additionVisitor := AtomicMonticelloAdditionVisitor new
		patch: patch;
		yourself.

	removeVisitor := AtomicMonticelloRemoveVisitor new
		patch: patch;
		yourself.

	modifyVisitor := AtomicMonticelloModifyVisitor new
		patch: patch;
		yourself
]

{ #category : #visitor }
AtomicMonticelloPatchConversor >> modifyDefinition: baseDefinition to: targetDefinition [
	modifyVisitor baseDefinition: baseDefinition.
	targetDefinition accept: modifyVisitor .
]

{ #category : #visitor }
AtomicMonticelloPatchConversor >> removeDefinition: aDefinition [
	aDefinition accept: removeVisitor .
]
