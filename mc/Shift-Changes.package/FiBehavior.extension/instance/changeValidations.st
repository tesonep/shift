*Shift-Changes
changeValidations
	^ super changeValidations , ShAbstractSingleChange allSubclasses
		,
			{ShSlotChange.
			ShClasspoolChange.
			ShSharedPoolChange}