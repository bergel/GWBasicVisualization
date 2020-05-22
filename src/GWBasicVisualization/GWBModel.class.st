Class {
	#name : #GWBModel,
	#superclass : #Object,
	#instVars : [
		'functions',
		'lineNumber',
		'files'
	],
	#category : #GWBasicVisualization
}

{ #category : #'as yet unclassified' }
GWBModel >> currentFile [
	self assert: [ files notEmpty ].
	^ files last
]

{ #category : #'as yet unclassified' }
GWBModel >> currentFunction [
	^ self currentFile functions last 
]

{ #category : #accessing }
GWBModel >> files [
	^ files
]

{ #category : #'as yet unclassified' }
GWBModel >> importFileAsText: aString [
	| f |
	f := GWBFile new.
	files add: f.
	
	aString lines doWithIndex: [ :l :i | 
		lineNumber := i.
		self processLine: l ]
]

{ #category : #'as yet unclassified' }
GWBModel >> inAFunction [
	files ifEmpty: [ ^ false ].
	self currentFile functions ifEmpty: [ ^ false ].
	^ true
]

{ #category : #initialization }
GWBModel >> initialize [
	super initialize.
	files := OrderedCollection new.
 
]

{ #category : #initialization }
GWBModel >> numberOfFunctions [
	files isEmpty ifTrue: [ ^ 0 ].
	^ (files collect: #numberOfFunctions) sum 
]

{ #category : #'as yet unclassified' }
GWBModel >> processLine: l [
	| ss f |
	ss := l substrings: String tab, ' '.
	ss ifEmpty: [ ^ self ].
	
	"We are defining a new function"
	ss first last = $: ifTrue: [ 
		f := GWBFunction new.
		f name: ss first.
		f lineNumber: lineNumber.
		self currentFile addFunction: f ].
	self inAFunction ifFalse: [ ^ self ]
]
