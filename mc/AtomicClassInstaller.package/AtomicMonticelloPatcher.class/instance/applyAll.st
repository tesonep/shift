applying
applyAll
	| additionVisitor removeVisitor |
	additionVisitor := AtomicMonticelloAdditionVisitor new.
	removeVisitor := AtomicMonticelloRemoveVisitor new.
	
	self packageAdditions do:[:e | e accept: additionVisitor].
	self classAdditions do:[:e | e accept:additionVisitor].
	self methodAdditions do:[:e | e accept:additionVisitor].

	self packageRemoves do:[:e | e accept: removeVisitor].
	self classRemoves do:[:e | e accept: removeVisitor].
	self methodRemoves do:[:e | e accept: removeVisitor].