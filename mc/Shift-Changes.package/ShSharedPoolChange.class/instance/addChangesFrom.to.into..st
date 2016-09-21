accessing
addChangesFrom: oldDefinition to: newDefinition into: results
	| newSharedPools oldSharedPools |
	newSharedPools := newDefinition sharedPools asArray.
	oldSharedPools := oldDefinition sharedPools asArray.
	
	newSharedPools
		do: [ :new | 
			oldSharedPools
				detect: [ :old | old = new ]
				ifNone: [ results
						add:
							(ShSharedPoolAdded new
								poolName: new;
								yourself) ] ].
						
	oldSharedPools
		do: [ :old | 
			newSharedPools
				detect: [ :new | old = new ]
				ifNone: [ results
						add:
							(ShSharedPoolRemoved new
								poolName: old;
								yourself) ] ]