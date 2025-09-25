Class {
	#name : 'BitbucketCloudPullRequestComment',
	#superclass : 'Object',
	#instVars : [
		'rawContent',
		'path',
		'fromLine',
		'toLine'
	],
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'converting' }
BitbucketCloudPullRequestComment >> asDictionary [ 
	| dictionary content inline |
	dictionary := Dictionary new.
	
	content := Dictionary new.
	rawContent ifNotNil: [ content at: #raw put: rawContent ]. 
	dictionary at: #content put: content.
	
	inline := Dictionary new.
	path ifNotNil: [ inline at: #path put: path ]. 
	fromLine ifNotNil: [ inline at: #start_to put: fromLine ].
	toLine ifNotNil: [ inline at: #to put: toLine ].
	inline ifNotEmpty: [	dictionary at: #inline put: inline.  ].
	
	^dictionary 
]

{ #category : 'accessing' }
BitbucketCloudPullRequestComment >> fromLine: anObject [

	fromLine := anObject
]

{ #category : 'accessing' }
BitbucketCloudPullRequestComment >> path: anObject [

	path := anObject
]

{ #category : 'accessing' }
BitbucketCloudPullRequestComment >> rawContent: anObject [

	rawContent := anObject
]

{ #category : 'accessing' }
BitbucketCloudPullRequestComment >> toLine: anObject [

	toLine := anObject
]
