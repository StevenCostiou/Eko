Class {
	#name : #EkoStateDebugger,
	#superclass : #EkoDebugger,
	#category : #Eko
}

{ #category : #'debug - control' }
EkoStateDebugger >> debugFailingRun [

	instrumenter reset.
	self introduceBugBlock value.
	instrumenter instrumentPackageList.
	self debug.
	failingRun := instrumenter traces.
	instrumenter reset
]

{ #category : #'debug - control' }
EkoStateDebugger >> debugWorkingRun [
	instrumenter reset.
	self fixBugBlock value.
	instrumenter instrumentPackageList.
	self debug.
	workingRun := instrumenter traces.
	instrumenter reset
]

{ #category : #'debug - control' }
EkoStateDebugger >> fixBugBlock [
	^self sourceBlock: configuration fixBugScript

	
]

{ #category : #'debug - control' }
EkoStateDebugger >> introduceBugBlock [
	^self sourceBlock: configuration introduceBugScript

	
]
