Class {
	#name : #GWBModel,
	#superclass : #Object,
	#instVars : [
		'functions'
	],
	#category : #GWBasicVisualization
}

{ #category : #initialization }
GWBModel >> initialize [
	super initialize.
	functions := OrderedCollection new
]

{ #category : #initialization }
GWBModel >> numberOfFunctions [
	^ functions size
]
