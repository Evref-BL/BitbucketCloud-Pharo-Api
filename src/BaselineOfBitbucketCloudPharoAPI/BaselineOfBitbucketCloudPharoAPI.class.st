Class {
	#name : 'BaselineOfBitbucketCloudPharoAPI',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfBitbucketCloudPharoAPI',
	#package : 'BaselineOfBitbucketCloudPharoAPI'
}

{ #category : 'baselines' }
BaselineOfBitbucketCloudPharoAPI >> baseline: spec [ 
	<baseline>
	spec for: #common do: [
		self defineDependencies: spec.
		self definePackages: spec.
		self defineGroups: spec ]
]

{ #category : 'baselines' }
BaselineOfBitbucketCloudPharoAPI >> defineDependencies: spec [ 

]

{ #category : 'baselines' }
BaselineOfBitbucketCloudPharoAPI >> defineGroups: spec [


]

{ #category : 'baselines' }
BaselineOfBitbucketCloudPharoAPI >> definePackages: spec [ 

	spec package: 'BitbucketCloudPharoAPI'.
	
	spec
		package: 'BitbucketCloudPharoAPI-Tests'
		with: [ spec requires: #( 'BitbucketPharoAPI' ) ].

]
