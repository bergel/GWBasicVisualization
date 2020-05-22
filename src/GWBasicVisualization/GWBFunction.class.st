Class {
	#name : #GWBFunction,
	#superclass : #Object,
	#instVars : [
		'file',
		'name',
		'incomingFunctions',
		'outgoingFunctions',
		'lineNumber',
		'fileName',
		'length',
		'sourceCode',
		'calledFunctionsNames'
	],
	#category : #GWBasicVisualization
}

{ #category : #initialization }
GWBFunction >> addCalledFunctionsName: aName [
	calledFunctionsNames add: aName
]

{ #category : #adding }
GWBFunction >> addIncomingCall: f [
	incomingFunctions add: f
]

{ #category : #adding }
GWBFunction >> addOutgoingCall: f [
	outgoingFunctions add: f
]

{ #category : #'as yet unclassified' }
GWBFunction >> calledFunctionNames [
	^ calledFunctionsNames
]

{ #category : #accessing }
GWBFunction >> file [
	^ file
]

{ #category : #accessing }
GWBFunction >> file: anObject [
	file := anObject
]

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

{ #category : #adding }
GWBFunction >> initialize [
	super initialize.
	outgoingFunctions := OrderedCollection new.
	incomingFunctions := OrderedCollection new.
	calledFunctionsNames := OrderedCollection new.
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
