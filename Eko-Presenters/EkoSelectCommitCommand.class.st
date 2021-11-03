"
I trigger the selection for eko-debugging of the commit selected in the commit table of `EkoTipHiedraHistoryPresenter`.
"
Class {
	#name : #EkoSelectCommitCommand,
	#superclass : #CmCommand,
	#category : #'Eko-Presenters'
}

{ #category : #'accessing - defaults' }
EkoSelectCommitCommand class >> defaultDescription [
	^ 'Selects this commit as the code modification introducing a bug.'
]

{ #category : #'accessing - defaults' }
EkoSelectCommitCommand class >> defaultName [ 

	^ 'Select commit'
]

{ #category : #executing }
EkoSelectCommitCommand >> execute [
	self context selectCommit
]
