"
I configure an eko debugging session based on a commit that introduce a failure.
You must select:
- an iceberg project
- a list of packages (by default, all of the iceberg project are there)
- the commit in that project that introduces your problem
"
Class {
	#name : #EkoCommitConfigurationPresenter,
	#superclass : #EkoAbstractConfigurationPresenter,
	#instVars : [
		'selectedProjectLabel',
		'selectProjectButton',
		'selectedPackagesLabel',
		'selectPackagesButton',
		'selectedCommitLabel',
		'selectCommitButton',
		'mainProjectLabel',
		'selectMainProjectDropList'
	],
	#category : #'Eko-Presenters'
}

{ #category : #specs }
EkoCommitConfigurationPresenter class >> defaultSpec [

	^ SpBoxLayout newTopToBottom
		  add: (SpBoxLayout newLeftToRight
				   add: #selectedProjectLabel;
				   add: #selectProjectButton withConstraints: [:c| c height: 24; width: 24];
				   yourself) expand: false fill: false padding: 5;
		  add: (SpBoxLayout newLeftToRight
				   add: #selectedPackagesLabel;
				   add: #selectPackagesButton withConstraints: [:c| c height: 24; width: 24];
				   yourself) expand: false fill: false padding: 5;
		  add: (SpBoxLayout newLeftToRight
				   add: #mainProjectLabel;
				   add: #selectMainProjectDropList;
				   yourself) expand: false fill: false padding: 5;
		  add: (SpBoxLayout newLeftToRight
				   add: #selectedCommitLabel;
				   add: #selectCommitButton withConstraints: [:c| c height: 24; width: 24];
				   yourself) expand: false fill: false padding: 5;
			add: (SpBoxLayout newTopToBottom
				   add: 'Code to debug:' expand: false fill: false padding: 5;
					add: (SpPanedLayout newLeftToRight
								positionOfSlider: 80 percent;
								add: #code;
								add: (SpBoxLayout newTopToBottom 
									add: #runDebuggerButton withConstraints: [:c| c height: 24; width: 60];
									add: #showResultsButton withConstraints: [:c| c height: 24; width: 60]; 
									yourself);
								yourself);
							yourself);
			yourself
]

{ #category : #initialization }
EkoCommitConfigurationPresenter >> initializePresenters [
	selectedProjectLabel := self newLabel.
	selectProjectButton := self newButton.
	selectProjectButton action:[self selectProjects].
	selectProjectButton icon: (self iconNamed: #config).	
	
	selectedPackagesLabel := self newLabel.
	selectPackagesButton := self newButton.
	selectPackagesButton action:[self selectPackages].
	selectPackagesButton icon: (self iconNamed: #config).	
		
	mainProjectLabel := self newLabel.
	mainProjectLabel label: 'Main project:'.
	selectMainProjectDropList := self newDropList.
	selectMainProjectDropList display: [ :iceRepo| iceRepo name ].
	selectMainProjectDropList whenSelectedItemChangedDo: [ :item| self ekoConfiguration mainProject: item ]. 
	
	selectedCommitLabel := self newLabel.
	selectCommitButton := self newButton.
	selectCommitButton action:[self selectCommit].
	selectCommitButton icon: (self iconNamed: #config).	
		
	super initializePresenters
]

{ #category : #actions }
EkoCommitConfigurationPresenter >> selectCommit [

	(EkoTipRepositoryPresenter
		 newOn:
		 (IceTipRepositoryModel on: selectMainProjectDropList selectedItem)
		 ekoConfiguration: ekoConfiguration
		 configurationPresenter: self) openWithSpec
]

{ #category : #actions }
EkoCommitConfigurationPresenter >> selectPackages [

	EkoPackageSelectionPresenter on: self ekoConfiguration parentPresenter: self
]

{ #category : #actions }
EkoCommitConfigurationPresenter >> selectProjects [

	EkoProjectSelectionPresenter on: self ekoConfiguration parentPresenter: self
]

{ #category : #updating }
EkoCommitConfigurationPresenter >> update [
	self updateSelectedProjectsLabel.
	self updateSelectedPackagesLabel.
	self updateSelectedCommitLabel.
	self updateMainProjectSelectionDropList.
	super update
]

{ #category : #updating }
EkoCommitConfigurationPresenter >> updateMainProjectSelectionDropList [

	| selectedItem |
	selectedItem := selectMainProjectDropList selectedItem.
	selectMainProjectDropList items: self ekoConfiguration projects.
	(self ekoConfiguration projects includes: selectedItem) ifFalse: [ 
		^ self ].
	selectMainProjectDropList selectItem: selectedItem
]

{ #category : #updating }
EkoCommitConfigurationPresenter >> updateSelectedCommitLabel [

	| str |
	str := WriteStream on: String new.
	str << ' Buggy commit:'.
	str space.
	self ekoConfiguration printSelectedCommitOn: str.	
	selectedCommitLabel label: str contents
]

{ #category : #updating }
EkoCommitConfigurationPresenter >> updateSelectedPackagesLabel [

	| str |
	str := WriteStream on: String new.
	str << self ekoConfiguration numberOfPackages printString.
	str space.
	str << 'package(s) selected'.
	selectedPackagesLabel label: str contents
]

{ #category : #updating }
EkoCommitConfigurationPresenter >> updateSelectedProjectsLabel [

	| str |
	str := WriteStream on: String new.
	str << self ekoConfiguration numberOfProjects printString.
	str space.
	str << 'project(s) selected'.
	selectedProjectLabel label: str contents
]
