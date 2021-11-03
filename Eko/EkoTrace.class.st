Class {
	#name : #EkoTrace,
	#superclass : #Object,
	#instVars : [
		'methodSignature',
		'traces'
	],
	#category : #Eko
}

{ #category : #accessing }
EkoTrace >> traceProxy: proxy [

	| str |
	str := WriteStream on: String new.
	str nextPutAll: proxy methodClass name.
	str nextPutAll: '››'.
	str nextPutAll: proxy selector.
	self traces add: str contents.
	str close
]

{ #category : #accessing }
EkoTrace >> traceProxy: proxy arguments: args [

	| str |
	str := WriteStream on: String new.
	str nextPutAll: proxy methodClass name.
	str nextPutAll: '››'.
	str nextPutAll: proxy selector.
	args ifNotEmpty: [ 
		str space.
		str nextPutAll: '(' ].
	args do: [ :arg | 
		str nextPutAll: arg printString.
		arg == args last ifFalse: [ 
			str nextPutAll: ','.
			str space ] ].
	args ifNotEmpty: [ str nextPutAll: ')' ].
	self traces add: str contents.
	str close
]

{ #category : #accessing }
EkoTrace >> traces [
 
	^ traces ifNil: [ traces := OrderedCollection new ]
]
