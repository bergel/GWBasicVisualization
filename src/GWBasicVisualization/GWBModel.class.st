Class {
	#name : #GWBModel,
	#superclass : #Object,
	#instVars : [
		'functions',
		'lineNumber'
	],
	#category : #GWBasicVisualization
}

{ #category : #'as yet unclassified' }
GWBModel >> importFileAsText: aString [

	aString lines doWithIndex: [ :l :i | 
		lineNumber := i.
		self processLine: l ]
]

{ #category : #initialization }
GWBModel >> initialize [
	super initialize.
	functions := OrderedCollection new
]

{ #category : #initialization }
GWBModel >> numberOfFunctions [
	^ functions size
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
		functions add: f. ]
]
