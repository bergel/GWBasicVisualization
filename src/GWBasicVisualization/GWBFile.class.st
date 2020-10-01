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
	"&begin[Adding]"
	functions add: f
	"&end[Adding]"
]

{ #category : #accessing }
GWBFile >> functions [
	"&begin[Modeling]"
	^ functions
	"&end[Modeling]"
]

{ #category : #computing }
GWBFile >> incomingFiles [
	"&begin[Modeling]"
	"&begin[Computing]"
	^ ((self functions flatCollect: #incomingFunctions) collect: #file as: Set) asArray
	"&end[Computing]"
	"&end[Modeling]"
]

{ #category : #initialization }
GWBFile >> initialize [
	super initialize.
	functions := OrderedCollection new
]

{ #category : #accessing }
GWBFile >> name [
	^ name
]

{ #category : #accessing }
GWBFile >> name: aString [
	name := aString
]

{ #category : #metric }
GWBFile >> numberOfFunctions [
	"&begin[Metric]"
	^ functions size
	"&end[Metric]"
]

{ #category : #accessing }
GWBFile >> numberOfLinesOfCode [
	"&begin[Metric]"
	^ numberOfLinesOfCode
	"&end[Metric]"
]

{ #category : #accessing }
GWBFile >> numberOfLinesOfCode: anInteger [
	"&begin[Metric]"
	numberOfLinesOfCode := anInteger
	"&end[Metric]"
]

{ #category : #computing }
GWBFile >> outgoingFiles [
	"&begin[Modeling]"
	"&begin[Computing]"
	^ ((self functions flatCollect: #outgoingFunctions) collect: #file as: Set) asArray
	"&end[Computing]"
	"&end[Modeling]"
]

{ #category : #printing }
GWBFile >> printOn: str [
	"&begin[Printing]"
	super printOn: str.
	str nextPut: $<.
	str nextPutAll: self name.
	str nextPut: $>.
	"&end[Printing]"
]
