as yet unclassified
baseline: spec
	<baseline>
	spec
		for: #pharo
		do:
			[ 
			spec package: 'AtomicClassInstaller'.
			spec package: 'AtomicClassInstaller-Tests' with:[ spec requires: #core ].	
			spec
				group: 'core' with: #('AtomicClassInstaller');
				group: 'dev' with: #('core' 'tests');
				group: 'tests' with: #('AtomicClassInstaller-Tests') ]