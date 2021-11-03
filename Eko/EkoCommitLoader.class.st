Class {
	#name : #EkoCommitLoader,
	#superclass : #Object,
	#instVars : [
		'commit',
		'workingCopy',
		'strategy'
	],
	#category : #Eko
}

{ #category : #accessing }
EkoCommitLoader >> commit: anObject [

	commit := anObject
]

{ #category : #loading }
EkoCommitLoader >> loadCommit [
	self strategy committish: commit.
	self strategy checkoutOn: workingCopy
]

{ #category : #accessing }
EkoCommitLoader >> strategy [

	^ strategy ifNil: [ 
		  strategy := IceCheckoutAllPackages new
			              committish: commit;
			              yourself ]
]

{ #category : #accessing }
EkoCommitLoader >> workingCopy: anObject [

	workingCopy := anObject
]
