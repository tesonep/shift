*Shift-Changes
layoutClassName
	^ self isWordsLayout
		ifTrue: [ #WordLayout ]
		ifFalse: [ #ByteLayout ]