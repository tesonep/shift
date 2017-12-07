Class {
	#name : #AtomicMonticelloRemoveVisitor,
	#superclass : #AtomicMonticelloAbstractVisitor,
	#category : 'AtomicClassInstaller-Monticello'
}

{ #category : #'as yet unclassified' }
AtomicMonticelloRemoveVisitor >> visitClassDefinition: aClassDefinition [
	patch addOperation: (APRemoveClass fromMCDefinition: aClassDefinition)
]

{ #category : #visitor }
AtomicMonticelloRemoveVisitor >> visitMethodDefinition: aMethodDefinition [ 
	patch addOperation: (APRemoveMethod fromMCDefinition: aMethodDefinition)
]

{ #category : #'as yet unclassified' }
AtomicMonticelloRemoveVisitor >> visitOrganizationDefinition: aDefinition [ 
	
]
