Class {
	#name : #BaselineOfShift,
	#superclass : #BaselineOf,
	#category : 'BaselineOfShift'
}

{ #category : #baseline }
BaselineOfShift >> baseline: spec [
	<baseline>
	spec
		for: #pharo
		do:
			[ 
			spec project: 'Ficus' with: [
				spec
					className: #ConfigurationOfFicus;
					versionString: #development;
					loads: #FicusMonticello;
					repository: 'http://smalltalkhub.com/mc/MartinDias/Ficus/main' ].
			
			spec package: 'Shift-ClassBuilder'.
			spec package: 'Shift-ClassInstaller'.

			spec package: 'Shift-Changes'.
			spec package: 'Shift-Changes-Tests' with:[spec requires: #'shift-core'].

			spec package: 'Shift-Changes-Ficus' with:[spec requires: #'Ficus'].
			spec package: 'Shift-Changes-Ficus-Tests' with:[spec requires: #('shift-core' 'Shift-Changes-Ficus')].

			spec package: 'Shift-ClassBuilder-Tests' with:[spec requires: #'shift-core'].
			spec package: 'Shift-ClassInstaller-Tests' with:[spec requires: #'shift-core'].

			spec
				group: 'core' with: #('Shift-Changes' 'Shift-ClassBuilder' 'Shift-ClassInstaller');
				group: 'dev' with: #('core' 'tests');
				group: 'shift-tests' with: #('Shift-Changes-Tests' 'Shift-ClassBuilder-Tests' 'Shift-ClassInstaller-Tests');
				group: 'shift-ficus-tests' with: #('Shift-Changes-Ficus-Tests'); 
				group: 'tests' with: #('shift-tests' 'shift-ficus-tests')				
			]
]
