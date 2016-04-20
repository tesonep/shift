as yet unclassified
baseline: spec
	<baseline>
	spec
		for: #pharo
		do:
			[ 
			spec
				package: 'AtomicClassInstaller'.
			
			spec
				group: 'core' with: #('AtomicClassInstaller');
				group: 'dev' with: #('core' 'tests');
				group: 'tests' with: #() ]