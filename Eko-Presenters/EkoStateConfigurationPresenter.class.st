"
I configure an eko debugging session based on a code which execution introduces a failure in a test case.
You must select:

- a list of packages on which we want to perform the eko
- a test method that works, _i.e._, the test is green when executed
- the code after which the test method becomes red (failure)
"
Class {
	#name : #EkoStateConfigurationPresenter,
	#superclass : #EkoAbstractConfigurationPresenter,
	#instVars : [
		'selectedProjectLabel',
		'selectProjectButton',
		'selectedPackagesLabel',
		'selectPackagesButton',
		'selectedCommitLabel',
		'selectCommitButton',
		'selectMainProjectDropList',
		'selectedTestMethodLabel',
		'selectTestMethodButton',
		'introduceTestFailureCode',
		'fixTestFailureCode'
	],
	#category : #'Eko-Presenters'
}

{ #category : #specs }
EkoStateConfigurationPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #selectedPackagesLabel;
				   add: #selectPackagesButton withConstraints: [:c| c height: 24; width: 24];
				   yourself) expand: false fill: false padding: 5;
		  add: (SpBoxLayout newLeftToRight
				   add: #selectedTestMethodLabel;
				   add: #selectTestMethodButton withConstraints: [:c| c height: 24; width: 24];
				   yourself) expand: false fill: false padding: 5;
			add: (SpBoxLayout newTopToBottom				   
					add: (SpPanedLayout newLeftToRight
								positionOfSlider: 80 percent;
								add:(SpBoxLayout newTopToBottom 
									add: 'Script to introduce test failure:' expand: false fill: false padding: 5;
									add: #introduceTestFailureCode;
									add: 'Script to remove the test failure:' expand: false fill: false padding: 5;
									add: #fixTestFailureCode;									yourself);
								add: (SpBoxLayout newTopToBottom 
									add: #runDebuggerButton withConstraints: [:c| c height: 34; width: 60; padding: 5];
									add: #showResultsButton withConstraints: [:c| c height: 24; width: 60]; 
									yourself);
								yourself);
							yourself);
			yourself
]

{ #category : #debugging }
EkoStateConfigurationPresenter >> buildDebugScript [
	^ '{1} new {2}' format: { 
			  ekoConfiguration methodToDebug methodClass name.
			  ekoConfiguration methodToDebug selector asString }
]

{ #category : #debugging }
EkoStateConfigurationPresenter >> debug [

	ekoConfiguration packages ifEmpty: [ ^ self ].
	ekoConfiguration introduceBugScript: introduceTestFailureCode text.
	ekoConfiguration fixBugScript: fixTestFailureCode text.
	ekoConfiguration sourceCode: self buildDebugScript.
	super debug
]

{ #category : #initialization }
EkoStateConfigurationPresenter >> initializePresenters [
	
	selectedPackagesLabel := self newLabel.
	selectPackagesButton := self newButton.
	selectPackagesButton action:[self selectPackages].
	selectPackagesButton icon: (self iconNamed: #config).	
		
	selectedTestMethodLabel := self newLabel.
	selectTestMethodButton := self newButton.
	selectTestMethodButton action:[self selectTestMethod].
	selectTestMethodButton icon: (self iconNamed: #config).	
		
	introduceTestFailureCode := self newCode.
	fixTestFailureCode := self newCode.
		
	super initializePresenters 
]

{ #category : #accessing }
EkoStateConfigurationPresenter >> methodToDebug: aCompiledMethod [ 
	self ekoConfiguration methodToDebug: aCompiledMethod.
	self updateSelectedTestMethodLabel
]

{ #category : #accessing }
EkoStateConfigurationPresenter >> newEkoDebuggerOn: anEkoConfiguration [

	^ EkoDebugger onStatekoConfiguration: ekoConfiguration
]

{ #category : #actions }
EkoStateConfigurationPresenter >> selectPackages [

	EkoPackageSelectionPresenter on: self ekoConfiguration parentPresenter: self
]

{ #category : #actions }
EkoStateConfigurationPresenter >> selectTestMethod [

	(EkoTipRepositoryPresenter
		 newOn:
		 (IceTipRepositoryModel on: selectMainProjectDropList selectedItem)
		 ekoConfiguration: ekoConfiguration
		 configurationPresenter: self) openWithSpec
]

{ #category : #updating }
EkoStateConfigurationPresenter >> update [

	self updateSelectedPackagesLabel.
	self updateSelectedTestMethodLabel.
	super update
]

{ #category : #updating }
EkoStateConfigurationPresenter >> updateSelectedPackagesLabel [

	| str |
	str := WriteStream on: String new.
	str << 'Package selection:'.
	str space.
	str << self ekoConfiguration numberOfPackages printString.
	str space.
	str << 'package(s) selected'.
	selectedPackagesLabel label: str contents
]

{ #category : #updating }
EkoStateConfigurationPresenter >> updateSelectedTestMethodLabel [

	| str |
	str := WriteStream on: String new.
	str << 'Test method:'.
	str space.
	self ekoConfiguration printSelectedTestMethodOn: str.	
	selectedTestMethodLabel label: str contents
]
