Class {
	#name : #EkoDebugger,
	#superclass : #Object,
	#instVars : [
		'failingRun',
		'workingRun',
		'instrumenter',
		'commitLoader',
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

{ #category : #accessing }
EkoDebugger >> commitLoader: anObject [

	commitLoader := anObject
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
		on: Error
		do: [ :e | instrumenter traces add: e printString ].
	instrumenter traces add: #end
]

{ #category : #'debug - control' }
EkoDebugger >> debugFailingRun [

	failingRun := self loadAndDebugCommit: self failingCommit
]

{ #category : #'debug - control' }
EkoDebugger >> debugWorkingRun [
	workingRun := self loadAndDebugCommit: self workingCommit
]

{ #category : #'debug - control' }
EkoDebugger >> ekoDebug [
	self debugFailingRun.
	self debugWorkingRun 
]

{ #category : #'private - accessing' }
EkoDebugger >> failingCommit [
	^configuration selectedCommit
]

{ #category : #initialization }
EkoDebugger >> initialize [

	
	commitLoader := EkoCommitLoader new.
	commitLoader workingCopy: self workingCopy.
	instrumenter := EkoPackageInstrumenter forPackages: configuration packages
	
]

{ #category : #accessing }
EkoDebugger >> instrumenter: anObject [

	instrumenter := anObject
]

{ #category : #'debug - control' }
EkoDebugger >> loadAndDebugCommit: aCommit [
	|results|
	instrumenter reset.
	commitLoader commit: aCommit.
	commitLoader loadCommit.
	instrumenter instrumentPackageList.
	self debug.
	results := instrumenter traces.
	instrumenter reset.
	^results
	
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

	| sourceStream |
	sourceStream := WriteStream on: String new.
	sourceStream << '['.
	sourceStream << configuration sourceCode.
	sourceStream << ']'.
	^ self class compiler evaluate: sourceStream contents
]

{ #category : #'private - accessing' }
EkoDebugger >> workingCommit [
	^self repository lookupCommit: self failingCommit ancestorIds first
]

{ #category : #'private - accessing' }
EkoDebugger >> workingCopy [
	^self repository workingCopy
]
