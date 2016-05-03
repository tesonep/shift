as yet unclassified
baseline: spec
	<baseline>
	spec
		for: #pharo
		do:
			[ 
			spec package: 'Slot'.
			spec package: 'AtomicClassInstaller'.
			spec package: 'AtomicClassInstaller-Tests' with:[ spec requires: #core ].	
			spec
				group: 'core' with: #(Slot AtomicClassInstaller);
				group: 'dev' with: #('core' 'tests');
				group: 'tests' with: #('AtomicClassInstaller-Tests') ]