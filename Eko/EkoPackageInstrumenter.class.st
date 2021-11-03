Class {
	#name : #EkoPackageInstrumenter,
	#superclass : #Object,
	#instVars : [
		'packages',
		'proxies',
		'ekoTrace'
	],
	#category : #Eko
}

{ #category : #environments }
EkoPackageInstrumenter class >> forPackages: packageArray [

	^ self new
		  packages: packageArray;
		  yourself
]

{ #category : #accessing }
EkoPackageInstrumenter >> ekoTrace [

	^ ekoTrace ifNil: [ ekoTrace := EkoTrace new ]
]

{ #category : #accessing }
EkoPackageInstrumenter >> handler [

	^ EkoMethodTraceHandler on: self ekoTrace
]

{ #category : #instrumentation }
EkoPackageInstrumenter >> instrumentPackageList [
	proxies := (packages flatCollect:[:p| p methods]) collect:[:m|
		MpMethodProxy onMethod: m handler: self handler].
	self proxies do:[:p| p install]
		
		
]

{ #category : #accessing }
EkoPackageInstrumenter >> packages: anObject [

	packages := anObject
]

{ #category : #accessing }
EkoPackageInstrumenter >> proxies [
	^ proxies ifNil:[proxies := OrderedCollection new]
]

{ #category : #initialization }
EkoPackageInstrumenter >> reset [
	self proxies do:[:p| p uninstall].
	ekoTrace := nil
]

{ #category : #accessing }
EkoPackageInstrumenter >> traces [
	^self handler trace traces
]
