Class {
	#name : #GWBFile,
	#superclass : #Object,
	#instVars : [
		'numberOfLinesOfCode',
		'functions',
		'name'
	],
	#category : #GWBasicVisualization
}

{ #category : #adding }
GWBFile >> addFunction: f [
	functions add: f
]

{ #category : #accessing }
GWBFile >> functions [
	^ functions
]

{ #category : #'as yet unclassified' }
GWBFile >> incomingFiles [
	^ ((self functions flatCollect: #incomingFunctions) collect: #file as: Set) asArray
]

{ #category : #adding }
GWBFile >> initialize [
	super initialize.
	functions := OrderedCollection new
]

{ #category : #accessing }
GWBFile >> name [
	^ name
]

{ #category : #accessing }
GWBFile >> name: anObject [
	name := anObject
]

{ #category : #initialization }
GWBFile >> numberOfFunctions [
	^ functions size
]

{ #category : #accessing }
GWBFile >> numberOfLinesOfCode [
	^ numberOfLinesOfCode
]

{ #category : #accessing }
GWBFile >> numberOfLinesOfCode: anObject [
	numberOfLinesOfCode := anObject
]

{ #category : #'as yet unclassified' }
GWBFile >> outgoingFiles [
	^ ((self functions flatCollect: #outgoingFunctions) collect: #file as: Set) asArray
]

{ #category : #printing }
GWBFile >> printOn: str [
	super printOn: str.
	str nextPut: $<.
	str nextPutAll: self name.
	str nextPut: $>.
]
