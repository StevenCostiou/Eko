"
I present a list of `IcePackage` to select for configuring an eko-debugging configuration. 
"
Class {
	#name : #EkoPackageSelectionPresenter,
	#superclass : #EkoAbstractProjectSelectionPresenter,
	#category : #'Eko-Presenters'
}

{ #category : #private }
EkoPackageSelectionPresenter >> activationBlock [

	^ [ :package | 
	  ekoConfiguration addPackageNamed: package name.
	  configurationPresenter update ]
]

{ #category : #private }
EkoPackageSelectionPresenter >> deactivationBlock [

	^ [ :package | 
	  ekoConfiguration removePackageNamed: package name.
	  configurationPresenter update ]
]

{ #category : #private }
EkoPackageSelectionPresenter >> evaluationBlock [

	^ [ :package | ekoConfiguration containsPackageNamed: package name]
]

{ #category : #private }
EkoPackageSelectionPresenter >> items [ 
	 ^ekoConfiguration projectsPackages
	
]
