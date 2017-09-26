*Shift-Changes-Ficus
changeValidations
	^ super changeValidations , ShAbstractSingleChange allSubclasses
		,
			{ShSlotChange.
			ShClasspoolChange.
			ShSharedPoolChange}