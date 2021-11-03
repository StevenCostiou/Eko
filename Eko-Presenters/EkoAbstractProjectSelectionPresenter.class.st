"
I present a list of project or packages and users select items to eko-debug from that list.
"
Class {
	#name : #EkoAbstractProjectSelectionPresenter,
	#superclass : #SpPresenter,
	#traits : 'TEkoConfigurator',
	#classTraits : 'TEkoConfigurator classTrait',
	#instVars : [
		'projectTable'
	],
	#category : #'Eko-Presenters'
}

{ #category : #specs }
EkoAbstractProjectSelectionPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: #projectTable;
		  yourself
]

{ #category : #'instance creation' }
EkoAbstractProjectSelectionPresenter class >> on: anEkoConfiguration parentPresenter: anEkoConfigurationPresenter [

	^ (self
		  on: anEkoConfiguration)
		  configurationPresenter: anEkoConfigurationPresenter;
		  openWithSpec
]

{ #category : #private }
EkoAbstractProjectSelectionPresenter >> activationBlock [

	^ self subclassResponsibility
]

{ #category : #accessing }
EkoAbstractProjectSelectionPresenter >> configurationPresenter: anObject [

	configurationPresenter := anObject
]

{ #category : #private }
EkoAbstractProjectSelectionPresenter >> deactivationBlock [

	^ self subclassResponsibility
]

{ #category : #private }
EkoAbstractProjectSelectionPresenter >> evaluationBlock [

	^ self subclassResponsibility
]

{ #category : #initialization }
EkoAbstractProjectSelectionPresenter >> initializePresenters [

	projectTable := self newTable.
	projectTable
		addColumn:
			((SpCheckBoxTableColumn title: ' ' evaluated: self evaluationBlock)
				 onActivation: self activationBlock;
				 onDeactivation: self deactivationBlock;
				 width: 20;
				 yourself);
		addColumn: (SpStringTableColumn title: 'Name' evaluated: #name);
		beResizable.
	projectTable items: self items
]

{ #category : #private }
EkoAbstractProjectSelectionPresenter >> items [ 
	 ^self subclassResponsibility 
	
]

{ #category : #initialization }
EkoAbstractProjectSelectionPresenter >> setModelBeforeInitialization: anEkoConfiguration [

	ekoConfiguration := anEkoConfiguration
]
