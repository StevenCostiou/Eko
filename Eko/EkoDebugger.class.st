Class {
	#name : #EkoDebugger,
	#superclass : #Object,
	#instVars : [
		'failingRun',
		'workingRun',
		'instrumenter',
		'configuration'
	],
	#category : #Eko
}

{ #category : #'instance creation' }
EkoDebugger class >> on: anEkoConfiguration [

	^ self basicNew
		  configuration: anEkoConfiguration;
		  initialize;
		  yourself
]

{ #category : #'instance creation' }
EkoDebugger class >> onCommitEkoConfiguration: anEkoConfiguration [
	^EkoCommitDebugger on: anEkoConfiguration 
]

{ #category : #'instance creation' }
EkoDebugger class >> onStatekoConfiguration: anEkoConfiguration [
	^EkoStateDebugger on: anEkoConfiguration 
]

{ #category : #'debug - control' }
EkoDebugger >> compareTraces [

	| failingText workingText |
	failingText := self printTrace: failingRun.
	workingText := self printTrace: workingRun.
	

	SpDiffPresenter new
		showOptions: false;
		leftText: failingText;
		rightText: workingText;
		openWithSpec
]

{ #category : #accessing }
EkoDebugger >> configuration [

	^ configuration
]

{ #category : #accessing }
EkoDebugger >> configuration: anObject [

	configuration := anObject
]

{ #category : #'debug - control' }
EkoDebugger >> debug [

	0.5 seconds wait.
	self sourceBlock
		on: Error , TestFailure
		do: [ :e | 
			(e isKindOf: TestFailure)
				ifTrue: [ instrumenter traces add: e printString ]
				ifFalse: [ 
					[ e resume ]
						on: Error
						do: [ instrumenter traces add: e printString ] ] ].
	instrumenter traces add: #end
]

{ #category : #'debug - control' }
EkoDebugger >> debugFailingRun [

	self subclassResponsibility 
]

{ #category : #'debug - control' }
EkoDebugger >> debugWorkingRun [

	self subclassResponsibility 
]

{ #category : #'debug - control' }
EkoDebugger >> ekoDebug [
	self debugFailingRun.
	self debugWorkingRun 
]

{ #category : #initialization }
EkoDebugger >> initialize [


	instrumenter := EkoPackageInstrumenter forPackages: configuration packages
	
]

{ #category : #accessing }
EkoDebugger >> instrumenter: anObject [

	instrumenter := anObject
]

{ #category : #'debug - control' }
EkoDebugger >> printTrace: aCollectionOfStrings [

	| str |
	str := WriteStream on: String new.
	aCollectionOfStrings reverseDo: [ :s | 
		str nextPutAll: s.
		str cr ].
	^ str contents
]

{ #category : #'private - accessing' }
EkoDebugger >> repository [
	^configuration mainProject
]

{ #category : #'debug - control' }
EkoDebugger >> sourceBlock [	
	^ self sourceBlock: configuration sourceCode
]

{ #category : #'debug - control' }
EkoDebugger >> sourceBlock: aString [

	| sourceStream |
	sourceStream := WriteStream on: String new.
	sourceStream << '['.
	sourceStream << aString.
	sourceStream << ']'.
	^ self class compiler evaluate: sourceStream contents
]

{ #category : #'private - accessing' }
EkoDebugger >> workingCopy [
	^self repository workingCopy
]
