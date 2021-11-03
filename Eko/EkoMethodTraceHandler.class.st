Class {
	#name : #EkoMethodTraceHandler,
	#superclass : #MpHandler,
	#instVars : [
		'traces',
		'trace'
	],
	#category : #Eko
}

{ #category : #'instance creation' }
EkoMethodTraceHandler class >> on: anEkoTrace [

	^ self new
		  trace: anEkoTrace;
		  yourself
]

{ #category : #accessing }
EkoMethodTraceHandler >> beforeExecutionWithReceiver: anObject arguments: anArrayOfObjects [
	trace traceProxy: proxy arguments: anArrayOfObjects
]

{ #category : #accessing }
EkoMethodTraceHandler >> beforeMethod [
"	trace traceProxy: proxy "
]

{ #category : #accessing }
EkoMethodTraceHandler >> trace [
	^trace
]

{ #category : #accessing }
EkoMethodTraceHandler >> trace: anEkoTrace [
	trace := anEkoTrace
]
