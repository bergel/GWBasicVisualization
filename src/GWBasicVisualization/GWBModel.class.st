Class {
	#name : #GWBModel,
	#superclass : #Object,
	#instVars : [
		'functions',
		'lineNumber',
		'files'
	],
	#category : #GWBasicVisualization
}

{ #category : #navigating }
GWBModel >> allFunctions [
	^ self files flatCollect: #functions
]

{ #category : #'as yet unclassified' }
GWBModel >> currentFile [
	self assert: [ files notEmpty ].
	^ files last
]

{ #category : #'as yet unclassified' }
GWBModel >> currentFunction [
	^ self currentFile functions last 
]

{ #category : #accessing }
GWBModel >> files [
	^ files
]

{ #category : #navigating }
GWBModel >> gtInspectorViewIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: 'View';
		initializeCanvas: [ self visualize ]
]

{ #category : #'as yet unclassified' }
GWBModel >> importFileAsText: aString [
	self importFileAsText: aString named: 'UNNAMED.ASM'
]

{ #category : #'as yet unclassified' }
GWBModel >> importFileAsText: aString named: aFileName [
	| f |
	f := GWBFile new.
	f name: aFileName.
	files add: f.
	
	aString lines doWithIndex: [ :l :i | 
		lineNumber := i.
		self processLine: l ]
]

{ #category : #'as yet unclassified' }
GWBModel >> importFromFolderNamed: aFullnameAsString [

	(aFullnameAsString asFileReference children) do: [ :f |
		(f basename endsWith: '.ASM')
			ifTrue: [ self importFileAsText: f contents named: f basename ]
	].
	self resolve.
]

{ #category : #'as yet unclassified' }
GWBModel >> inAFunction [
	files ifEmpty: [ ^ false ].
	self currentFile functions ifEmpty: [ ^ false ].
	^ true
]

{ #category : #initialization }
GWBModel >> initialize [
	super initialize.
	files := OrderedCollection new.
 
]

{ #category : #initialization }
GWBModel >> numberOfFunctions [
	files isEmpty ifTrue: [ ^ 0 ].
	^ (files collect: #numberOfFunctions) sum 
]

{ #category : #'as yet unclassified' }
GWBModel >> processLine: l [
	| ss f |
	ss := l substrings: String tab, ' '.
	ss ifEmpty: [ ^ self ].
	
	"We are defining a new function"
	ss first last = $: ifTrue: [ 
		f := GWBFunction new.
		f name: ss first allButLast.
		f lineNumber: lineNumber.
		self currentFile addFunction: f ].
	self inAFunction ifFalse: [ ^ self ].

	f := self currentFunction.
	
	(#('CALL' 'JZ' 'JMP' 'JNZ' 'JB') includes: ss first) ifTrue: [ f addCalledFunctionsName: (ss copyWithout: 'SHORT') second ]
]

{ #category : #navigating }
GWBModel >> resolve [
	| d calledFunction |
	d := Dictionary new.
	self allFunctions do: [ :f | d at: f name put: f ].
	
	"Does not work because there are some duplicated keys"
	"d := (self allFunctions select: [:f | (f name beginsWith: '??') not ] thenCollect: [ :f | f name -> f ]) asDictionary."
	
	self allFunctions do: [ :f |
		f calledFunctionNames do: [ :fName |
			(d includesKey: fName) ifTrue: [ 
				calledFunction := d at: fName.
				f addOutgoingCall: calledFunction.
				calledFunction addIncomingCall: f ] ] ]
]

{ #category : #'as yet unclassified' }
GWBModel >> run [
	<script: 'self new run inspect'>
	self importFromFolderNamed: '/Users/alexandrebergel/Desktop/GW-BASIC'
]

{ #category : #navigating }
GWBModel >> visualize [
	| c shapes eb |
	c := RSCanvas new.
	shapes := self allFunctions 
		collect: [ :f | RSEllipse new size: 10; color: Color blue translucent; model: f ] as: RSGroup.
	c addAll: shapes.
	shapes @ RSPopup @ RSDraggable.
	
	eb := RSEdgeBuilder line.
	eb canvas: c.
	eb moveBehind.
	eb shapes: shapes.
	eb connectToAll: #outgoingFunctions.
	RSForceBasedLayout on: shapes.
	c @ RSCanvasController.
	
	^ c
]
