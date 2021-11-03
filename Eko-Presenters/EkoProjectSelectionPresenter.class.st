"
I present a list of `IceRepository` to select for configuring an eko-debugging configuration. 
"
Class {
	#name : #EkoProjectSelectionPresenter,
	#superclass : #EkoAbstractProjectSelectionPresenter,
	#category : #'Eko-Presenters'
}

{ #category : #private }
EkoProjectSelectionPresenter >> activationBlock [

	^ [ :iceProject | 
	  ekoConfiguration addProject: iceProject.
	  configurationPresenter update ]
]

{ #category : #private }
EkoProjectSelectionPresenter >> deactivationBlock [

	^ [ :iceProject | 
	  ekoConfiguration removeProject: iceProject.
	  configurationPresenter update ]
]

{ #category : #private }
EkoProjectSelectionPresenter >> evaluationBlock [

	^ [ :iceProject | ekoConfiguration containsProject: iceProject ]
]

{ #category : #private }
EkoProjectSelectionPresenter >> items [ 
	 ^IceRepository repositories
	
]
