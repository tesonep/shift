Extension { #name : #APCreatePackage }

{ #category : #'*AtomicClassInstaller-UI' }
APCreatePackage >> displayString [
	^ 'Package ' , package
]

{ #category : #'*AtomicClassInstaller-UI' }
APCreatePackage >> icon [
	^ Smalltalk ui icons iconNamed: #add
]
