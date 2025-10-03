Class {
	#name : 'BitbucketCloudApi',
	#superclass : 'Object',
	#instVars : [
		'client',
		'accessToken',
		'host',
		'basePath',
		'output',
		'apiToken',
		'username'
	],
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'accessing' }
BitbucketCloudApi >> accessToken: anObject [

	accessToken := anObject
]

{ #category : 'accessing' }
BitbucketCloudApi >> apiToken: anObject [

	apiToken := anObject
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

{ #category : 'accessing' }
BitbucketCloudApi >> output: anObject [

	output := anObject
]

{ #category : 'initialization' }
BitbucketCloudApi >> prepareClient [

	client prepareRequest.
	client resetEntity.
	client host: host.
	client https.

	accessToken ifNotNil: [
		client headerAt: #Authorization put: 'Bearer ' , accessToken ].

	apiToken ifNotNil: [ client username: username password: apiToken ]
]

{ #category : 'ressources' }
BitbucketCloudApi >> pullRequests [
	^BitbucketCloudPullRequests new bitbucketCloudApi: self.
]

{ #category : 'ressources' }
BitbucketCloudApi >> refs [
	^BitbucketCloudRefs new bitbucketCloudApi: self.
]

{ #category : 'ressources' }
BitbucketCloudApi >> repositories [
	^BitbucketCloudRepositories new bitbucketCloudApi: self.
]

{ #category : 'ressources' }
BitbucketCloudApi >> source [
	^BitbucketCloudSource new bitbucketCloudApi: self.
]

{ #category : 'accessing' }
BitbucketCloudApi >> username: anObject [

	username := anObject
]
