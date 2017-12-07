Class {
	#name : #APProcessTest,
	#superclass : #TestCase,
	#instVars : [
		'semaphore',
		'process'
	],
	#category : 'AtomicClassInstaller-Tests-Process'
}

{ #category : #'as yet unclassified' }
APProcessTest >> setUp [
	super setUp.
	semaphore := Semaphore new.

]

{ #category : #'as yet unclassified' }
APProcessTest >> tearDown [
	semaphore ifNotNil: [ [ semaphore isEmpty not ] whileTrue: [ semaphore signal ] ]
]

{ #category : #'as yet unclassified' }
APProcessTest >> testDetectingQuiescentProcesses [
	| process2 mockProcess tool | 
	
	process := [ semaphore wait ] fork.

	mockProcess := ACIMockProcess new.
	mockProcess semaphore: semaphore.

	process2 := [ mockProcess run ] fork.
	
	Processor yield.
	
	tool := ACIProcessTool new.
	tool addModifiedMethod: #(#ACIMockProcess #run).
	
	self assert: (tool isQuiescent: process).
	self deny: (tool isQuiescent: process2).
	self assertCollection: (tool nonQuiescentProcess) equals: { process2 }.
]

{ #category : #'as yet unclassified' }
APProcessTest >> testInterleaveInProcess [
	| first second mockProcess p |
	first := Semaphore new.
	second := Semaphore new.
		
	mockProcess := ACIMockProcess new.
	mockProcess semaphore: first.
	
	p := [ mockProcess run ] fork.
	
	Processor yield.
	
	ACIProcessTool new interleaveBlock: [ second signal ]  afterBlockedProcess: p.
	
	first signal.
	
   self deny:(second waitTimeoutSeconds: 1).
]

{ #category : #'as yet unclassified' }
APProcessTest >> testLocateProcesses [
	| ps | 
	
	(Delay forSeconds: 5) wait.
	
	ps := ACIProcessTool new nonSystemProcesses.
	
	ps isEmpty ifFalse:[
		ps do:[:e | self log:e longPrintString ]
	].
	
	self assertCollection: ps equals: #().
]

{ #category : #'as yet unclassified' }
APProcessTest >> testNewProcessLocateProcesses [
	| ps | 
	
	process := [ semaphore ifNotNil:#wait ] fork.
	
	ps := ACIProcessTool new nonSystemProcesses.
	self assert: ps isNotEmpty.
]

{ #category : #'as yet unclassified' }
APProcessTest >> testResumeOfAProcess [	
	| s2 apProcessTool |
	apProcessTool := ACIProcessTool new.
	
	s2 := Semaphore new.
	process := [ semaphore wait. s2 signal. ] fork.	

	apProcessTool suspendProcess: process.
	
	self assert: (s2 waitTimeoutSeconds: 1).
	
	apProcessTool resumeProcess: process.
	
	semaphore signal.
	self deny: (s2 waitTimeoutSeconds: 1).

]

{ #category : #'as yet unclassified' }
APProcessTest >> testWaitingForQuiescenseProcesses [
	| process2 mockProcess mockProcess2 tool | 

	mockProcess := ACIMockProcess new.
	mockProcess semaphore: semaphore.
	process := [ mockProcess runWithoutMagic ] forkAt:50.
		
	mockProcess2 := ACIMockProcess new.
	mockProcess2 semaphore: semaphore.
	process2 := [ mockProcess2 run ] forkAt:50.
	
	Processor yield.
	
	tool := ACIProcessTool new.
	tool addModifiedMethod: #(ACIMockProcess #run).
	
	[ 
		(Delay forSeconds: 3) wait.
		semaphore signal.
		semaphore signal.
	 ] fork.	
	
	tool waitAllQuiescent.
	self assert:tool numberOfWaits > 0. 
]

{ #category : #'as yet unclassified' }
APProcessTest >> testWaitingForQuiescenseProcessesNeverArrives [
	| process2 mockProcess mockProcess2 tool | 

	mockProcess := ACIMockProcess new.
	mockProcess semaphore: semaphore.
	process := [ mockProcess runWithoutMagic ] forkAt:50.
		
	mockProcess2 := ACIMockProcess new.
	mockProcess2 semaphore: semaphore.
	process2 := [ mockProcess2 run ] forkAt:50.
	
	Processor yield.
	
	tool := ACIProcessTool new.
	tool addModifiedMethod: #(ACIMockProcess #run).
	
	self should:[tool waitAllQuiescent]  raise:Error. 

	self assert:tool numberOfWaits = 5. 
	
	semaphore signal.
	semaphore signal.

]
