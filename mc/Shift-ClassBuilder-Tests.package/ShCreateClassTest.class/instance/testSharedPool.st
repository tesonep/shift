as yet unclassified
testSharedPool
	builder name: #SHClassWithSharedPool.
	result := builder
		sharedPools: 'ShTestSharedPool';
		build.

	self validateResult.
	self validateSuperclass: Object.
	self validateSharedPools: {ShTestSharedPool}