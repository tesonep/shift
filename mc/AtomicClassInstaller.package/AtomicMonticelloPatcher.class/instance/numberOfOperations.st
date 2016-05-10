initialization
numberOfOperations
	^ packageAdditions size + classAdditions size + methodAdditions size + packageRemoves size
		+ classRemoves size + methodRemoves size