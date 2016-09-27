class building
build
	| newMetaclass newClass |
	
	newMetaclass := Metaclass new.
	newMetaclass 
		superclass: self superclass class
		withLayoutType: FixedLayout 
		slots: self layoutDefinition classSlots.
		
	newClass := newMetaclass new.
	newClass setName: self name.
	
	newClass
		superclass: self superclass
		withLayoutType: self layoutType
		slots: self layoutDefinition slots.
		
	^ newClass.