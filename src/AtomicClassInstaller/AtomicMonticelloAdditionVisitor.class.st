Class {
	#name : #AtomicMonticelloAdditionVisitor,
	#superclass : #AtomicMonticelloAbstractVisitor,
	#category : 'AtomicClassInstaller-Monticello'
}

{ #category : #'as yet unclassified' }
AtomicMonticelloAdditionVisitor >> visitClassDefinition: aClassDefinition [
	patch
		addOperation:
			(aClassDefinition actualClass
				ifNil: [ APCreateClass fromMCDefinition: aClassDefinition ]
				ifNotNil: [ APModifyClass fromMCDefinition: aClassDefinition ])
]

{ #category : #'as yet unclassified' }
AtomicMonticelloAdditionVisitor >> visitMethodDefinition: aMethodDefinition [ 
	patch addOperation: (APAddMethod fromMCDefinition: aMethodDefinition).
]

{ #category : #'as yet unclassified' }
AtomicMonticelloAdditionVisitor >> visitOrganizationDefinition: aOrganizationDefinition [
	aOrganizationDefinition categories do: [ :e | patch addOperation: (APCreatePackage new package: e) ]
]
