compiling
binding
	"Answer a binding for the receiver, sharing if possible"

	| binding |
	binding := self environment associationAt: self name ifAbsent: [ nil ].
	^ (binding isNotNil and: [ binding value == self ])
		ifTrue: [ binding ]
		ifFalse: [ ^ self methodDict
				ifEmpty: [ nil -> self ]
				ifNotEmpty: [ :dict | dict anyOne classBinding ] ]