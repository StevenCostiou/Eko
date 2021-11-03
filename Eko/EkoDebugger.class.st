Class {
	#name : #EkoDebugger,
	#superclass : #Object,
	#instVars : [
		'failingRun',
		'workingRun',
		'instrumenter',
		'commitLoader',
		'runMethod',
		'failingCommit',
		'workingCommit',
		'testClass',
		'testSelector'
	],
	#category : #Eko
}

{ #category : #'instance creation' }
EkoDebugger class >> ekoDebugTest: testMethod betweenFailing: failingCommit andWorkingCommit: workingCommit [

	^ self new
		  testMethod: testMethod;
		  failingCommit: failingCommit;
		  workingCommit: workingCommit;
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

{ #category : #'debug - control' }
EkoDebugger >> debug [

	[ testClass new perform: testSelector ]
		on: Error
		do: [ :e | instrumenter traces add: e printString ].
	instrumenter traces add: #end
]

{ #category : #'debug - control' }
EkoDebugger >> debugFailingRun [

	failingRun := self loadAndDebugCommit: failingCommit
]

{ #category : #'debug - control' }
EkoDebugger >> debugWorkingRun [
	workingRun := self loadAndDebugCommit: workingCommit
]

{ #category : #initialize }
EkoDebugger >> initialize [

	| repo workingCopy packages |
	repo := IceRepository repositories detect: [ :r | 
		        r name = 'OCDEval-Tasks' ].
	workingCopy := repo workingCopy.

	failingCommit := workingCopy referenceCommit.
	workingCommit := repo lookupCommit: failingCommit ancestorIds first.
	
	commitLoader := EkoCommitLoader new.
	commitLoader workingCopy: workingCopy.

	packages := { AtomMorph package }.
	instrumenter := EkoPackageInstrumenter forPackages: packages.
	
	testClass := OCDTaskTest.
	testSelector := #testAtomMorphSelection
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
