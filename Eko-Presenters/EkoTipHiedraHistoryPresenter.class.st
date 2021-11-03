"
I hack iceberg commands to reuse the `IceTipHiedraHistoryBrowser` presenter safely without any possible actions on commits.
"
Class {
	#name : #EkoTipHiedraHistoryPresenter,
	#superclass : #IceTipHiedraHistoryBrowser,
	#traits : 'TEkoConfigurator',
	#classTraits : 'TEkoConfigurator classTrait',
	#instVars : [
		'configurationPresenter'
	],
	#category : #'Eko-Presenters'
}

{ #category : #commands }
EkoTipHiedraHistoryPresenter class >> buildSelectionCommandGroupWith: presenter for: aCommandGroup [

	{ EkoSelectCommitCommand } do: [ :each | 
		aCommandGroup register: each forSpec ]
]

{ #category : #accessing }
EkoTipHiedraHistoryPresenter >> configurationPresenter: anObject [

	configurationPresenter := anObject
]

{ #category : #actions }
EkoTipHiedraHistoryPresenter >> selectCommit [
	ekoConfiguration selectCommit: self selectedCommit.
	configurationPresenter update
]
