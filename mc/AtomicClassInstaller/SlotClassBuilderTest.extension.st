Extension { #name : #SlotClassBuilderTest }

{ #category : #'*AtomicClassInstaller' }
SlotClassBuilderTest >> make: anUnaryBlock [
	"I build a class for testing, providing basic default values, but eventually customized by the received unary block."

	^Smalltalk classInstaller make: [:builder|
		builder
			superclass: Object;
			name: self aClassName;
			layoutClass: FixedLayout;
			category: self aCategory.
		anUnaryBlock value: builder
		].
]