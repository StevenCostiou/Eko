"
I hack iceberg commands to reuse the `IceTipRepositoryBrowser` presenter safely without any possible actions on repositories and their branches.
"
Class {
	#name : #EkoTipRepositoryPresenter,
	#superclass : #IceTipRepositoryBrowser,
	#traits : 'TEkoConfigurator',
	#classTraits : 'TEkoConfigurator classTrait',
	#instVars : [
		'configurationPresenter'
	],
	#category : #'Eko-Presenters'
}

{ #category : #commands }
EkoTipRepositoryPresenter class >> buildGeneralCommandGroupWith: presenter for: aCommandGroup [
]

{ #category : #commands }
EkoTipRepositoryPresenter class >> buildSelectionCommandGroupWith: presenter for: aCommandGroup [
]

{ #category : #'instance creation' }
EkoTipRepositoryPresenter class >> newOn: aModel ekoConfiguration: ekoConfiguration configurationPresenter: configurationPresenter [

	^ self basicNew
		  application: self currentApplication;
		  setModelBeforeInitialization: aModel;
		  ekoConfiguration: ekoConfiguration;
		  configurationPresenter: configurationPresenter;
		  initialize;
		  yourself
]

{ #category : #accessing }
EkoTipRepositoryPresenter >> configurationPresenter: anObject [

	configurationPresenter := anObject
]

{ #category : #initialization }
EkoTipRepositoryPresenter >> initializePresenters [

	super initializePresenters.

	historyPanel := self
		                instantiate: EkoTipHiedraHistoryPresenter
		                on: self model headModel.
	historyPanel configurationPresenter: configurationPresenter.
	historyPanel ekoConfiguration: ekoConfiguration
]
