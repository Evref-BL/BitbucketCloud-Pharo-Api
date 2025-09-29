Class {
	#name : 'BitbucketCloudPullRequestCreate',
	#superclass : 'Object',
	#instVars : [
		'sourceBranch',
		'destinationBranch',
		'title'
	],
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'converting' }
BitbucketCloudPullRequestCreate >> asDictionary [ 
	| dictionary source destination |
	dictionary := Dictionary new.
	
	title ifNotNil: [ dictionary at: #title put: title ]. 
	
	source := Dictionary new.
	sourceBranch ifNotNil: [ source at: #branch put: ({ #name -> sourceBranch } asDictionary)  ].
	source ifNotEmpty: [ dictionary at: #source put: source ].
	
	destination := Dictionary new.
	destinationBranch ifNotNil: [ destination at: #branch put: ({ #name -> destinationBranch } asDictionary)  ].
	destination ifNotEmpty: [ dictionary at: #destination put: destination ].
	
	^dictionary
]

{ #category : 'accessing' }
BitbucketCloudPullRequestCreate >> destinationBranch: anObject [

	destinationBranch := anObject
]

{ #category : 'accessing' }
BitbucketCloudPullRequestCreate >> sourceBranch: anObject [

	sourceBranch := anObject
]

{ #category : 'accessing' }
BitbucketCloudPullRequestCreate >> title: anObject [

	title := anObject
]
