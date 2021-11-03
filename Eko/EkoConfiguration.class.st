Class {
	#name : #EkoConfiguration,
	#superclass : #Object,
	#instVars : [
		'projects',
		'commit',
		'packagesNames'
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

{ #category : #initialization }
EkoConfiguration >> initialize [

	projects := OrderedCollection new.
	packagesNames := OrderedCollection new
]

{ #category : #'api-configuration' }
EkoConfiguration >> numberOfPackages [

	^packagesNames size
]

{ #category : #'api-configuration' }
EkoConfiguration >> numberOfProjects [

	^projects size
]

{ #category : #printing }
EkoConfiguration >> printSelectedCommitOn: aStream [
	commit ifNil:[^self].
	aStream << commit id
]

{ #category : #accessing }
EkoConfiguration >> projects [
	^ projects
]

{ #category : #'api-configuration' }
EkoConfiguration >> projectsPackages [

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

{ #category : #'as yet unclassified' }
EkoConfiguration >> selectCommit: anIceTipCachedModel [ 
	commit := anIceTipCachedModel realObject entity
]
