Class {
	#name : #ACIAbstractBrowser,
	#superclass : #Object,
	#instVars : [
		'browser'
	],
	#category : 'AtomicClassInstaller-UI'
}

{ #category : #'as yet unclassified' }
ACIAbstractBrowser >> browser [
	^ browser ifNil: [ self buildBrowser ]
]

{ #category : #'as yet unclassified' }
ACIAbstractBrowser >> buildBrowser [
	self doBuildBrowser.
	browser title: self title.
	^ browser
]

{ #category : #'as yet unclassified' }
ACIAbstractBrowser >> doBuildBrowser [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
ACIAbstractBrowser >> open [
	self browser openOn: self roots.
]

{ #category : #'as yet unclassified' }
ACIAbstractBrowser >> roots [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
ACIAbstractBrowser >> title [
	self subclassResponsibility 
]
