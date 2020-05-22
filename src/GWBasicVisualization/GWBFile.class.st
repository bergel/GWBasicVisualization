Class {
	#name : #GWBFile,
	#superclass : #Object,
	#instVars : [
		'functions'
	],
	#category : #GWBasicVisualization
}

{ #category : #adding }
GWBFile >> addFunction: f [
	functions add: f
]

{ #category : #adding }
GWBFile >> initialize [
	super initialize.
	functions := OrderedCollection new
]

{ #category : #initialization }
GWBFile >> numberOfFunctions [
	^ functions size
]
