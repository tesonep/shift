tests
testClassWithComment
	builder name: #SHClassWithComment.
	result := builder
					comment: 'I have a comment'; 
					commentStamp: 'anStamp';
					build.
	
	self validateResult.
	self validateSuperclass: Object.

	self assert: result comment equals: 'I have a comment'.
	self assert: result organization commentStamp equals: 'anStamp'.