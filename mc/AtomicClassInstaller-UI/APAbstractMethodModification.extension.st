Extension { #name : #APAbstractMethodModification }

{ #category : #'*AtomicClassInstaller-UI' }
APAbstractMethodModification >> displayString [
	^ modifiedClassName , ' >> ' , selector
]
