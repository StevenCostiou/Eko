Class {
	#name : #EkoAbstractConfigurationPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'ekoConfiguration',
		'showResultsButton',
		'debugger',
		'code',
		'progressBar',
		'runDebuggerButton'
	],
	#category : #'Eko-Presenters'
}

{ #category : #actions }
EkoAbstractConfigurationPresenter >> debug [

	self layout: (self layout add: progressBar).
	debugger := self newEkoDebuggerOn: ekoConfiguration.
	[[debugger ekoDebug] ensure:[self layout: self class defaultSpec]] fork
	
]

{ #category : #accessing }
EkoAbstractConfigurationPresenter >> ekoConfiguration [

	^ ekoConfiguration ifNil: [ ekoConfiguration := EkoConfiguration new ]
]

{ #category : #initialization }
EkoAbstractConfigurationPresenter >> initializeDebugButtonPresenter [

	runDebuggerButton := self newButton.
	runDebuggerButton action: [ self debug ].
	runDebuggerButton icon: (self iconNamed: #glamorousBug).
	runDebuggerButton label: 'Debug'
]

{ #category : #initialization }
EkoAbstractConfigurationPresenter >> initializePresenters [ 

	code := self newCode.
	
	self initializeDebugButtonPresenter.
	self initializeShowResultsButtonPresenter.
	
	progressBar := self newProgressBar.
	progressBar indeterminate. 
	
	self update
]

{ #category : #initialization }
EkoAbstractConfigurationPresenter >> initializeShowResultsButtonPresenter [

	showResultsButton := self newButton.
	showResultsButton action: [ debugger compareTraces ].
	showResultsButton icon: (self iconNamed: #glamorousSearch).
	showResultsButton label: 'Results'
]

{ #category : #accessing }
EkoAbstractConfigurationPresenter >> newEkoDebuggerOn: anEkoConfiguration [

	^ self subclassResponsibility
]

{ #category : #accessing }
EkoAbstractConfigurationPresenter >> title [
	^'Eko configuration'
]

{ #category : #accessing }
EkoAbstractConfigurationPresenter >> windowIcon [
	^self iconNamed: #glamorousBug
]
