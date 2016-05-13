as yet unclassified
setUp
	super setUp.
	baselineLoader := AtomicMetacelloBaselineLoader baseline: 'TokyoDB' repository: 'filetree://tokyodb/mc'.
	patcher := AtomicMonticelloPatcher new.
	AtomicClassInstaller reset