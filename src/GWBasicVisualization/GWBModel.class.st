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
	"&begin[Computing]"
	^ self files flatCollect: #functions
	"&end[Computing]"
]

{ #category : #'private - parsing' }
GWBModel >> currentFile [
	"&begin[File]"
	"&begin[Assertion]"
	self assert: [ files notEmpty ].
	"&end[Assertion]"
	^ files last
	"&end[File]"
]

{ #category : #'private - parsing' }
GWBModel >> currentFunction [
	"&begin[Computing]"
	^ self currentFile functions last 
	"&end[Computing]"
]

{ #category : #accessing }
GWBModel >> files [
	"&begin[File]"
	^ files
	"&end[File]"
]

{ #category : #navigating }
GWBModel >> gtInspectorFilesIn: composite [
	"&begin[Inspector]"
	"&begin[Visualization]"
	<gtInspectorPresentationOrder: -10>
	composite roassal3
		title: 'Files';
		initializeCanvas: [ self visualizeFiles ]
	"&end[Visualization]"
	"&end[Inspector]"
]

{ #category : #navigating }
GWBModel >> gtInspectorFunctionsIn: composite [
	<gtInspectorPresentationOrder: -10>
	"&begin[Inspector]"
	"&begin[Visualization]"
	composite roassal3
		title: 'Functions';
		initializeCanvas: [ self visualizeFunctions ]
	"&end[Visualization]"
	"&end[Inspector]"
	
]

{ #category : #'public - importing' }
GWBModel >> importFileAsText: aString [
	"&begin[Import]"
	self importFileAsText: aString named: 'UNNAMED.ASM'
	"&end[Import]"
]

{ #category : #'public - importing' }
GWBModel >> importFileAsText: aString named: aFileName [
	"&begin[Import]"
	| f |
	"&begin[Modeling]"
	f := GWBFile new.
	f name: aFileName.
	f numberOfLinesOfCode: aString lines size.
	files add: f.
	"&end[Modeling]"

	"&begin[Parsing]"
	aString lines doWithIndex: [ :l :i | 
		lineNumber := i.
		self processLine: l ]
	"&end[Parsing]"
	"&end[Import]"
]

{ #category : #'public - importing' }
GWBModel >> importFromFolderNamed: aFullnameAsString [
	"&begin[Parsing]"
	(aFullnameAsString asFileReference children) do: [ :f |
		(f basename endsWith: '.ASM')
			ifTrue: [ self importFileAsText: f contents named: f basename ]
	].
	"&end[Parsing]"
	"&begin[SymbolResolution]"
	self resolve.
	"&end[SymbolResolution]"
	
]

{ #category : #'private - parsing' }
GWBModel >> inAFunction [
	"&begin[File]"
	files ifEmpty: [ ^ false ].
	self currentFile functions ifEmpty: [ ^ false ].
	"&end[SymbolResolution]"
	^ true
	
]

{ #category : #initialization }
GWBModel >> initialize [
	super initialize.
	files := OrderedCollection new.
 
]

{ #category : #initialization }
GWBModel >> numberOfFunctions [
	"&begin[Metric]"
	files isEmpty ifTrue: [ ^ 0 ].
	^ (files collect: #numberOfFunctions) sum 
	"&end[Metric]"
]

{ #category : #'private - parsing' }
GWBModel >> processLine: l [
	"&begin[Parsing]"
	| ss f |
	ss := l substrings: String tab, ' '.
	ss ifEmpty: [ ^ self ].
	
	"We are defining a new function"
	ss first last = $: ifTrue: [ 
		"&begin[Modeling]"
		f := GWBFunction new.
		f name: ss first allButLast.
		f lineNumber: lineNumber.
		"&end[Modeling]"
		self currentFile addFunction: f.
		f file: self currentFile ].
	self inAFunction ifFalse: [ ^ self ].
	"&end[Parsing]"
	
	f := self currentFunction.
	
	"&begin[Cleaning]"
	(#('CALL' 'JZ' 'JMP' 'JNZ' 'JB') includes: ss first) ifTrue: [ f addCalledFunctionsName: (ss copyWithout: 'SHORT') second ]
	"&end[Cleaning]"
]

{ #category : #navigating }
GWBModel >> resolve [
	"&begin[SymbolResolution]"
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
	"&end[SymbolResolution]"
]

{ #category : #'public - running' }
GWBModel >> run [
	"&begin[Example]"
	<script: 'self new run inspect'>
	"To have it to run, you need to downoad the GWBasic repository from: http://github.com/dspinellis/GW-BASIC"
	self importFromFolderNamed: '/Users/alexandrebergel/Dropbox/GitRepos/GW-BASIC'
	"&end[Example]"

]

{ #category : #navigating }
GWBModel >> visualizeFiles [
	"&begin[Visualization]"
	| c shapes eb |
	c := RSCanvas new.
	shapes := self files 
		collect: [ :f | RSBox new size: 10; color: Color blue translucent; model: f ] as: RSGroup.
	c addAll: shapes.
	shapes @ RSPopup @ RSDraggable.
	
	eb := RSEdgeBuilder line.
	eb moveBehind.
	eb shape color: Color gray translucent.
	eb canvas: c.
	eb moveBehind.
	eb shapes: shapes.
	eb connectToAll: #outgoingFiles.
	
	RSNormalizer size
		shapes: shapes;
		from: 5;
		to: 20;
		normalize: #numberOfLinesOfCode.
	
	RSForceBasedLayout new charge: -400; on: shapes.
	c @ RSCanvasController.
	
	^ c
	"&end[Visualization]"
]

{ #category : #navigating }
GWBModel >> visualizeFunctions [
	"&begin[Visualization]"
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
	"RSGridLayout on: shapes."
	
	RSNormalizer color
		shapes: shapes;
		scale: NSScale category20b;
		normalize: [ :fun | files indexOf: fun file ].
	
	c @ RSCanvasController.
	
	^ c
	"&end[Visualization]"
]
