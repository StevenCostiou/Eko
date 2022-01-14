Class {
	#name : #ClyEkoDebugMethodCommand,
	#superclass : #ClyBrowserCommand,
	#category : #'Eko-Presenters'
}

{ #category : #activation }
ClyEkoDebugMethodCommand class >> browserMenuOrder [
	<classAnnotationDependency>
	^-1
]

{ #category : #activation }
ClyEkoDebugMethodCommand class >> contextMenuOrder [
	<classAnnotationDependency>
	^-1
]

{ #category : #activation }
ClyEkoDebugMethodCommand class >> fullBrowserMenuActivation [

	<classAnnotation>
	^ CmdContextMenuActivation
		  byItemOf: ClyDebuggingMenuGroup
		  for: ClyFullBrowserMethodContext
]

{ #category : #accessing }
ClyEkoDebugMethodCommand >> defaultMenuIconName [
	^#smallDebug
]

{ #category : #accessing }
ClyEkoDebugMethodCommand >> defaultMenuItemName [
	^'Eko debug...'
]

{ #category : #execution }
ClyEkoDebugMethodCommand >> execute [
	|compiledMethod eko|
	compiledMethod := browser methodView selection actualObjects first.
	eko := EkoStateConfigurationPresenter new.
	eko methodToDebug: compiledMethod.
	eko openWithSpec  
]
