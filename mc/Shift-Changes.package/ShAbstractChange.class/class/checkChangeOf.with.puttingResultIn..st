checking change
checkChangeOf: oldDefinition with: newDefinition puttingResultIn: results
	| example |
	example := self new.
	(example hasChanged: oldDefinition with: newDefinition)
		ifTrue: [ example fillFrom: oldDefinition to: newDefinition.
			results add: example ]