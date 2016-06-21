actions
impact	
	self classifyInOrganizer.
	self classifyInRPackage.	

	self assert:[ self newPackage includesClass: modifiedClass ]. 
	self assert:[ (self packageOrganizer packageOf: modifiedClass) == self newPackage ]. 
		
	^ self.