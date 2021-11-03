"
I am used to transversally provide access to a shared eko configuration and the presenter that created that configuration.

My `configurationPresenter` inst var is the presenter that opened me, so that I can trigger an update of that presenter when an item is selected in my list.
My `ekoConfiguration` inst var is the object configuring an eko-debugger shared among all presenters instantiated from my `configurationPresenter`.
"
Trait {
	#name : #TEkoConfigurator,
	#instVars : [
		'ekoConfiguration',
		'configurationPresenter'
	],
	#category : #'Eko-Presenters'
}

{ #category : #accessing }
TEkoConfigurator >> configurationPresenter [

	^ configurationPresenter
]

{ #category : #accessing }
TEkoConfigurator >> configurationPresenter: anObject [

	configurationPresenter := anObject
]

{ #category : #accessing }
TEkoConfigurator >> ekoConfiguration [

	^ ekoConfiguration
]

{ #category : #accessing }
TEkoConfigurator >> ekoConfiguration: anObject [

	ekoConfiguration := anObject
]
