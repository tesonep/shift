private
doExecuteNotifying: aBlock 
	| undos |
	self changeClass rename: newName.
	undos := changes collect: [ :each | 
		(each renameChangesForClass: oldName asSymbol to: newName asSymbol) 
			doExecuteNotifying: aBlock ].
	^ self copy
		changes: undos reverse;
		rename: newName to: oldName;
		yourself