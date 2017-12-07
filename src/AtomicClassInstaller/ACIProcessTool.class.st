Class {
	#name : #ACIProcessTool,
	#superclass : #Object,
	#instVars : [
		'suspendedLists',
		'modifiedMethods',
		'semaphore',
		'waitingFor',
		'numberOfWaits'
	],
	#category : 'AtomicClassInstaller-Process'
}

{ #category : #adding }
ACIProcessTool >> addAllModifiedMethod: aCollection [ 
	modifiedMethods addAll: aCollection.
]

{ #category : #adding }
ACIProcessTool >> addModifiedMethod: aPair [ 
	modifiedMethods add: aPair.
]

{ #category : #private }
ACIProcessTool >> addSignalContextAndWait: aProcess [
	(waitingFor includes: aProcess)
		ifFalse: [ 
			waitingFor add: aProcess.
			self interleaveBlock: [ self processArrivedSyncPoint: Processor activeProcess ] afterBlockedProcess: aProcess ]
]

{ #category : #initialization }
ACIProcessTool >> initialize [
	super initialize.
	suspendedLists := Dictionary new.
	modifiedMethods := Set new.
	waitingFor := Set new.
	semaphore := Semaphore new.
	numberOfWaits := 0.
]

{ #category : #'interleaving contexts' }
ACIProcessTool >> interleave: anObject selector: aSelector afterContext: aContext [
	| newContext method |
	method := anObject class lookupSelector: aSelector.
	newContext := Context newForMethod: method.
	newContext
		setSender: nil
		receiver: anObject
		method: method
		arguments: #().
	aContext insertSender: newContext.
	^newContext.
]

{ #category : #'interleaving contexts' }
ACIProcessTool >> interleaveBlock: aBlock afterBlockedProcess: aProcess [
	| apContext |
	apContext := ACIContext new
		block: aBlock;
		yourself.
	^ self interleave: apContext selector: #doInTheMiddle afterContext: aProcess suspendedContext.
]

{ #category : #'querying processes' }
ACIProcessTool >> isQuiescent: aProcess [
	"A process is quiescent if it is not the active and it does not activate any of the modified methods"

	aProcess isActiveProcess
		ifTrue: [ ^ false ].
	^ (aProcess suspendedContext
		callChainAnySatisfy:
			[ :ctx | modifiedMethods anySatisfy: [ :pair | ctx method selector = pair second and: [ ctx method methodClass name = pair first ] ] ])
		not
]

{ #category : #'querying processes' }
ACIProcessTool >> isSystemProcess: aProcess [
	^ aProcess suspendedContext callChainAnySatisfy: [ :e | self systemProcessMethods anySatisfy: [ :x | e method selector = x value and: [ e methodClass name = x key ] ] ]
]

{ #category : #accessing }
ACIProcessTool >> modifiedMethods [
	^ modifiedMethods
]

{ #category : #'querying processes' }
ACIProcessTool >> nonQuiescentProcess [
	^self nonSystemProcesses reject:[:e | self isQuiescent: e].
]

{ #category : #'querying processes' }
ACIProcessTool >> nonSystemProcesses [
	^ Process allInstances reject:[:e | e isTerminated or:[e suspendedContext isNil or: [self isSystemProcess:e]]].
]

{ #category : #accessing }
ACIProcessTool >> numberOfWaits [
	^ numberOfWaits
]

{ #category : #'process events' }
ACIProcessTool >> processArrivedSyncPoint: aProcess [
	waitingFor remove: aProcess.
	semaphore signal.
	Processor yield.
]

{ #category : #'process control' }
ACIProcessTool >> resumeProcess: aProcess [
 	| aList |
	aList := suspendedLists at: aProcess.
	^aList addLast: aProcess. 
]

{ #category : #'process control' }
ACIProcessTool >> suspendProcess: aProcess [
 	| aList |
	aList := aProcess suspend.
	suspendedLists at: aProcess put: aList.
	^aList.
]

{ #category : #accessing }
ACIProcessTool >> suspendedLists [
	^ suspendedLists
]

{ #category : #private }
ACIProcessTool >> systemProcessMethods [
	^ {(#MorphicUIManager -> #spawnNewProcess).
	(#SmalltalkImage -> #lowSpaceWatcher).
	(#InputEventFetcher -> #eventLoop).
	(#'ProcessorScheduler class' -> #idleProcess).
	(#'WeakArray class' -> #finalizationProcess).
	(#OSSVMProcess -> #initializeChildWatcher).
	(#DelayMicrosecondScheduler -> #runTimerEventLoop).
	(#DelayMillisecondScheduler -> #runTimerEventLoop).
	(#TestExecutionEnvironment -> #watchDogLoopFor:)}
]

{ #category : #'as yet unclassified' }
ACIProcessTool >> waitAllQuiescent [
	| nonQuiescents |
	nonQuiescents := self nonQuiescentProcess.
	nonQuiescents ifEmpty: [ ^self ].
	
	nonQuiescents do:[:e | self addSignalContextAndWait: e ].
	
	(semaphore waitTimeoutSeconds: 2) ifTrue:[ 
		numberOfWaits := numberOfWaits + 1.
		numberOfWaits = 5 ifTrue:[ self error: 'Waiting for too long :(' ]	
	].
	
	^ self waitAllQuiescent.
]

{ #category : #accessing }
ACIProcessTool >> waitingFor [
	^ waitingFor
]
