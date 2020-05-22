Class {
	#name : #GWBasicTest,
	#superclass : #TestCase,
	#instVars : [
		'm'
	],
	#category : #GWBasicVisualization
}

{ #category : #running }
GWBasicTest >> setUp [
	"Hooks that subclasses may override to define the fixture of test."
	m := GWBModel new
]

{ #category : #tests }
GWBasicTest >> testEmpty [
	self assert: m numberOfFunctions equals: 0
]
