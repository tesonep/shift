accessing
addChangesFrom: oldDefinition to: newDefinition into: results
	| newClassPoolEntries oldClassPoolEntries |
	newClassPoolEntries := newDefinition classPool asArray.
	oldClassPoolEntries := oldDefinition classPool asArray.
	
	newClassPoolEntries
		do: [ :new | 
			oldClassPoolEntries
				detect: [ :old | old = new ]
				ifNone: [ results
						add:
							(ShClasspoolAdded new
								entryName: new;
								yourself) ] ].
						
	oldClassPoolEntries
		do: [ :old | 
			newClassPoolEntries
				detect: [ :new | old = new ]
				ifNone: [ results
						add:
							(ShClasspoolRemoved new
								entryName: old;
								yourself) ] ]