Class {
	#name : #GWBFile,
	#superclass : #Object,
	#instVars : [
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
