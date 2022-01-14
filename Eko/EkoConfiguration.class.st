Class {
	#name : #EkoConfiguration,
	#superclass : #Object,
	#instVars : [
		'projects',
		'commit',
		'packagesNames',
		'mainProject',
		'sourceCode',
		'introduceBugScript',
		'fixBugScript',
		'methodToDebug'
	],
	#category : #Eko
}

{ #category : #'api-configuration' }
EkoConfiguration >> addPackageNamed: aPackageName [
	packagesNames addIfNotPresent: aPackageName 
]

{ #category : #'api-configuration' }
EkoConfiguration >> addProject: anIceRepository [
	projects addIfNotPresent: anIceRepository.
	anIceRepository workingCopy packages do:[:iceP| self addPackageNamed: iceP name]
]

{ #category : #'api-configuration' }
EkoConfiguration >> containsPackageNamed: aProject [

	^ packagesNames includes: aProject
]

{ #category : #'api-configuration' }
EkoConfiguration >> containsProject: aProject [
	^projects includes: aProject
]

{ #category : #accessing }
EkoConfiguration >> fixBugScript [

	^ fixBugScript
]

{ #category : #accessing }
EkoConfiguration >> fixBugScript: anObject [

	fixBugScript := anObject
]

{ #category : #initialization }
EkoConfiguration >> initialize [

	projects := OrderedCollection new.
	packagesNames := OrderedCollection new
]

{ #category : #accessing }
EkoConfiguration >> introduceBugScript [

	^ introduceBugScript
]

{ #category : #accessing }
EkoConfiguration >> introduceBugScript: anObject [

	introduceBugScript := anObject
]

{ #category : #accessing }
EkoConfiguration >> mainProject [

	^ mainProject
]

{ #category : #accessing }
EkoConfiguration >> mainProject: anUndefinedObject [ 
	mainProject := anUndefinedObject 
]

{ #category : #accessing }
EkoConfiguration >> methodToDebug [

	^ methodToDebug
]

{ #category : #accessing }
EkoConfiguration >> methodToDebug: anObject [

	methodToDebug := anObject
]

{ #category : #'api-configuration' }
EkoConfiguration >> numberOfPackages [

	^packagesNames size
]

{ #category : #'api-configuration' }
EkoConfiguration >> numberOfProjects [

	^projects size
]

{ #category : #accessing }
EkoConfiguration >> packages [

	self flag:
		'Just testing. Looks wrong. Why are why not working with packages in the first place?'.
	projects ifEmpty: [ 
		^ packagesNames collect: [ :p | 
			  RPackageOrganizer default packageNamed: p ] ].
	^ self projectsPackages collect: [ :p | 
		  RPackageOrganizer default packageNamed: p name ]
]

{ #category : #printing }
EkoConfiguration >> printSelectedCommitOn: aStream [
	commit ifNil:[^self].
	aStream << commit id
]

{ #category : #printing }
EkoConfiguration >> printSelectedTestMethodOn: aWriteStream [

	methodToDebug ifNil: [ ^ self ].
	methodToDebug printOn: aWriteStream
]

{ #category : #accessing }
EkoConfiguration >> projects [
	^ projects
]

{ #category : #'api-configuration' }
EkoConfiguration >> projectsPackages [
	projects ifEmpty: [^RPackage organizer packages].
	^ (projects collect: [ :p | p workingCopy packages ]) flattened
]

{ #category : #'api-configuration' }
EkoConfiguration >> removePackageNamed: aPackageName [
	packagesNames remove: aPackageName ifAbsent: [  ] 
]

{ #category : #'api-configuration' }
EkoConfiguration >> removeProject: anIceRepository [
	projects remove: anIceRepository ifAbsent:[].
	anIceRepository workingCopy packages do:[:iceP| self removePackageNamed: iceP name]
]

{ #category : #'api-configuration' }
EkoConfiguration >> selectCommit: anIceTipCachedModel [ 
	commit := anIceTipCachedModel realObject entity
]

{ #category : #'api-configuration' }
EkoConfiguration >> selectedCommit [
	^commit
]

{ #category : #accessing }
EkoConfiguration >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
EkoConfiguration >> sourceCode: aString [ 
	sourceCode := aString
]
