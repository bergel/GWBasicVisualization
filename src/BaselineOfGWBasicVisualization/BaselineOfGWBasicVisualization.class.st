Class {
	#name : #BaselineOfGWBasicVisualization,
	#superclass : #BaselineOf,
	#category : #BaselineOfGWBasicVisualization
}

{ #category : #baselines }
BaselineOfGWBasicVisualization >> baseline: spec [
	<baseline>
	spec for: #common do: [ spec
		baseline: 'Roassal3' with: [ spec repository: 'github://ObjectProfile/Roassal3/src'; loads: #('Full') ];
		package: 'GWBasicVisualization';

		group: 'default' with: #('GWBasicVisualization');
		group: 'core' with: #('default')
 ]
]
