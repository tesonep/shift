private
doExecuteNotifying: aBlock 
	| undo |
	self addNewVariable.
	self copyOldValuesToNewVariable.
	undo := super doExecuteNotifying: aBlock.
	undo
		oldName: newName;
		newName: oldName.
	self removeOldVariable.
	^ undo