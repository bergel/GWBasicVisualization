Class {
	#name : #GWBModel,
	#superclass : #Object,
	#instVars : [
		'functions',
		'lineNumber',
		'file',
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
GWBModel >> importFileAsText: aString [
	file := GWBFile new.
	files add: file.
	
	aString lines doWithIndex: [ :l :i | 
		lineNumber := i.
		self processLine: l ]
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
		self currentFile addFunction: f ]
]
