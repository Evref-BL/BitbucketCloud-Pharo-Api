Class {
	#name : 'BitbucketCloudApi',
	#superclass : 'Object',
	#instVars : [
		'client',
		'accessToken',
		'host',
		'basePath',
		'output'
	],
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'accessing' }
BitbucketCloudApi >> accessToken: anObject [

	accessToken := anObject
]

{ #category : 'accessing' }
BitbucketCloudApi >> basePath [

	^ basePath
]

{ #category : 'accessing' }
BitbucketCloudApi >> client [

	^ client
]

{ #category : 'accessing' }
BitbucketCloudApi >> client: anObject [

	client := anObject
]

{ #category : 'accessing' }
BitbucketCloudApi >> host: anObject [

	host := anObject
]

{ #category : 'initialization' }
BitbucketCloudApi >> initialize [
	client := ZnClient new
		          accept: ZnMimeType applicationJson;
		          yourself.

	basePath := '2.0'.
	
	output := 'dict'
]

{ #category : 'accessing' }
BitbucketCloudApi >> output [

	^ output
]

{ #category : 'as yet unclassified' }
BitbucketCloudApi >> prepareClient [
	client prepareRequest.
	client host: host.
	client https.
	
   accessToken ifNotNil: [  
		client headerAt: #Authorization put: 'Bearer ' , accessToken ].
]

{ #category : 'accessing' }
BitbucketCloudApi >> pullRequests [
	^BitbucketCloudPullRequests new bitbucketCloudApi: self.
]

{ #category : 'accessing' }
BitbucketCloudApi >> repositories [
	^BitbucketCloudRepositories new bitbucketCloudApi: self.
]
