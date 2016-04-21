notifications
basicClassDefinitionChangedFrom: oldClass to: newClass using: classModification 
	" Copy over the trait composition "
	self copyTraitCompositionFrom: oldClass to: newClass.		
	" Copy over the method organization "
	newClass organization: oldClass organization.

	"Handle subclass changes"
	oldClass superclass == newClass superclass ifFalse: [ 
		self removeSubclass: oldClass to:oldClass superclass.
		self addSubclass: newClass to:newClass superclass.
	].
