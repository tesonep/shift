private
doExecuteNotifying: aBlock 
	| undos undo |
	undos := changes collect: [ :each | each doExecuteNotifying: aBlock ].
	undo := self copy.
	undo changes: undos reversed.
	^ undo