*Shift-Changes
changeValidations
	^ super changeValidations
		,
			{ShClassRename.
			ShSuperclassChange.
			ShSlotChange.
			ShClasspoolChange.
			ShSharedPoolChange}