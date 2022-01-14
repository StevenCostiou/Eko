Class {
	#name : #EkoCommitDebugger,
	#superclass : #EkoDebugger,
	#instVars : [
		'commitLoader'
	],
	#category : #Eko
}

{ #category : #accessing }
EkoCommitDebugger >> commitLoader: anObject [

	commitLoader := anObject
]

{ #category : #'debug - control' }
EkoCommitDebugger >> debugFailingRun [

	failingRun := self loadAndDebugCommit: self failingCommit
]

{ #category : #'debug - control' }
EkoCommitDebugger >> debugWorkingRun [
	workingRun := self loadAndDebugCommit: self workingCommit
]

{ #category : #'private - accessing' }
EkoCommitDebugger >> failingCommit [
	^configuration selectedCommit
]

{ #category : #initialization }
EkoCommitDebugger >> initialize [
	super initialize.
		
	commitLoader := EkoCommitLoader new.
	commitLoader workingCopy: self workingCopy.
]

{ #category : #'debug - control' }
EkoCommitDebugger >> loadAndDebugCommit: aCommit [
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

{ #category : #'private - accessing' }
EkoCommitDebugger >> workingCommit [
	^self repository lookupCommit: self failingCommit ancestorIds first
]
