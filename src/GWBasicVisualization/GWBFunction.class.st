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
	"&begin[Adding]"
	calledFunctionsNames add: aName
	"&end[Adding]"
]

{ #category : #adding }
GWBFunction >> addIncomingCall: f [
	"&begin[Adding]"
	incomingFunctions add: f
	"&begin[End]"
]

{ #category : #adding }
GWBFunction >> addOutgoingCall: f [
	"&begin[Adding]"
	outgoingFunctions add: f
	"&end[Adding]"
]

{ #category : #accessing }
GWBFunction >> calledFunctionNames [
	^ calledFunctionsNames
]

{ #category : #accessing }
GWBFunction >> file [
	"&begin[File]"
	^ file
	"&end[File]"
]

{ #category : #accessing }
GWBFunction >> file: aFile [
	"&begin[File]"
	file := aFile
	"&end[File]"
]

{ #category : #accessing }
GWBFunction >> fileName [
	"&begin[File]"
	^ fileName
	"&end[File]"
]

{ #category : #accessing }
GWBFunction >> fileName: aFilenameAsString [
	"&begin[File]"
	fileName := aFilenameAsString
	"&end[File]"
]

{ #category : #accessing }
GWBFunction >> incomingFunctions [
	"&begin[Modeling]"
	^ incomingFunctions
	"&end[Modeling]"
]

{ #category : #accessing }
GWBFunction >> incomingFunctions: someIncomdingFunctions [
	"&begin[Modeling]"
	incomingFunctions := someIncomdingFunctions
	"&begin[Modeling]"
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
	"&begin[Metric]"
	^ length
	"&end[Metric]"
]

{ #category : #accessing }
GWBFunction >> length: anInteger [
	"&begin[Metric]"
	length := anInteger
	"&end[Metric]"
]

{ #category : #accessing }
GWBFunction >> lineNumber [
	"&begin[Metric]"
	^ lineNumber
	"&end[Metric]"
]

{ #category : #accessing }
GWBFunction >> lineNumber: anInteger [
	"&begin[Metric]"
	lineNumber := anInteger
	"&end[Metric]"
]

{ #category : #accessing }
GWBFunction >> name [
	"&begin[Modeling]"
	^ name
	"&end[Modeling]"
]

{ #category : #accessing }
GWBFunction >> name: nameAsString [
	"&begin[Modeling]"
	name := nameAsString
	"&end[Modeling]"
]

{ #category : #accessing }
GWBFunction >> outgoingFunctions [
	"&begin[Modeling]"
	^ outgoingFunctions
	"&end[Modeling]"
]

{ #category : #accessing }
GWBFunction >> outgoingFunctions: someFunctions [
	"&begin[Modeling]"
	outgoingFunctions := someFunctions
	"&end[Modeling]"
]

{ #category : #printing }
GWBFunction >> printOn: str [
	"&begin[Printing]"
	super printOn: str.
	str nextPut: $<.
	str nextPutAll: self name.
	str nextPut: $>.
	"&end[Printing]"
]

{ #category : #accessing }
GWBFunction >> sourceCode [
	"&begin[File]"
	^ sourceCode
	"&end[File]"
]

{ #category : #accessing }
GWBFunction >> sourceCode: aString [
	"&begin[File]"
	sourceCode := aString
	"&end[File]"
]
