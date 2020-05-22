Class {
	#name : #GWBFunction,
	#superclass : #Object,
	#instVars : [
		'name',
		'incomingFunctions',
		'outgoingFunctions',
		'lineNumber',
		'fileName',
		'length',
		'sourceCode'
	],
	#category : #GWBasicVisualization
}

{ #category : #accessing }
GWBFunction >> fileName [
	^ fileName
]

{ #category : #accessing }
GWBFunction >> fileName: anObject [
	fileName := anObject
]

{ #category : #accessing }
GWBFunction >> incomingFunctions [
	^ incomingFunctions
]

{ #category : #accessing }
GWBFunction >> incomingFunctions: anObject [
	incomingFunctions := anObject
]

{ #category : #accessing }
GWBFunction >> length [
	^ length
]

{ #category : #accessing }
GWBFunction >> length: anObject [
	length := anObject
]

{ #category : #accessing }
GWBFunction >> lineNumber [
	^ lineNumber
]

{ #category : #accessing }
GWBFunction >> lineNumber: anObject [
	lineNumber := anObject
]

{ #category : #accessing }
GWBFunction >> name [
	^ name
]

{ #category : #accessing }
GWBFunction >> name: anObject [
	name := anObject
]

{ #category : #accessing }
GWBFunction >> outgoingFunctions [
	^ outgoingFunctions
]

{ #category : #accessing }
GWBFunction >> outgoingFunctions: anObject [
	outgoingFunctions := anObject
]

{ #category : #accessing }
GWBFunction >> sourceCode [
	^ sourceCode
]

{ #category : #accessing }
GWBFunction >> sourceCode: anObject [
	sourceCode := anObject
]
