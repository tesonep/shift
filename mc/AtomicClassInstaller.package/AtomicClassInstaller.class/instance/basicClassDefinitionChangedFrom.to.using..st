notifications
basicClassDefinitionChangedFrom: oldClass to: newClass using: classModification 
	" Copy over the trait composition "
	self copyTraitCompositionFrom: oldClass to: newClass.		
	" Copy over the method organization "
	newClass organization: oldClass organization.
