Class {
	#name : #ACIDefaultObjectMigratorProvider,
	#superclass : #AbstractClassInstaller,
	#category : 'AtomicClassInstaller-Migrators'
}

{ #category : #'as yet unclassified' }
ACIDefaultObjectMigratorProvider >> objectMigratorFor: oldClass to: newClass [
	^ ACIDefaultObjectMigrator new.
]
