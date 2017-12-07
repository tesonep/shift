Class {
	#name : #AtomicPatchBrowser,
	#superclass : #ACIAbstractBrowser,
	#instVars : [
		'patch',
		'labels'
	],
	#category : 'AtomicClassInstaller-UI'
}

{ #category : #'as yet unclassified' }
AtomicPatchBrowser class >> openOn: aPatch [
	^ self new
		patch: aPatch;
		open
]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> childrenOf: aValue [
	aValue = #operations
		ifTrue: [ ^ self patch operations ].

	aValue = #transformations
		ifTrue: [ ^ self patch transformations ].
	
	^#()	
]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> contentsIn: builder [
	builder fastTree
		title: 'Patch Content';
		children: [ :item | self childrenOf: item];
		format: [:item | self displayFor: item];
		icon: [ :item | self iconFor: item ]
]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> detailsIn: builder [
	builder text
		title: [ :item | item asString ];
		display: [ :item | item asString ];
		when: [ :item | item isSymbol not ].

	builder text
		title: 'Pre-execution Script';
		display: [ patch preScript ifNil: '' ];
		when: [ :item | item = #preScript ].

	builder text
		title: 'Post-execution Script';
		display: [ patch postScript ifNil: '' ];
		when: [ :item | item = #postScript ]
]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> displayFor: aValue [
	aValue isSymbol ifFalse: [ ^aValue displayString ].
	^ (labels at:aValue) first.
]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> doBuildBrowser [
	browser := GLMTabulator new.
	browser column: #content.
	browser column: #detail.
	browser transmit
		to: #content;
		andShow: [ :builder | self contentsIn: builder ].
	browser transmit
		from:#content;
		to: #detail;
		andShow: [ :builder | self detailsIn: builder ].

]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> iconFor: aValue [
	aValue isSymbol ifFalse: [ ^aValue icon ].
	^ (labels at:aValue) second.
]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> initialize [
	| icons | 
	super initialize.
	
	icons := Smalltalk ui icons.
	
	labels := {
		#preScript -> {'Pre-Execution Script'.  icons iconNamed: #glamorousBrowse}.
		#postScript -> {'Post-Execution Script'. icons iconNamed: #glamorousBrowse}.
		#transformations -> {'Transformations'. icons iconNamed: #glamorousRefresh}.
		#operations -> {'Operations'. icons iconNamed: #glamorousSpawn}
		} asDictionary
]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> patch [
	^ patch
]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> patch: anObject [
	patch := anObject
]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> roots [
	^#(preScript operations transformations postScript)
]

{ #category : #'as yet unclassified' }
AtomicPatchBrowser >> title [
	^'Browse Atomic Patch'
]
