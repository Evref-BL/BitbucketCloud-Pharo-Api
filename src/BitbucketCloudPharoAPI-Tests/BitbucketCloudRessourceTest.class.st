"
A BitbucketCloudRessourceTest is a test class for testing the behavior of BitbucketCloudRessource
"
Class {
	#name : 'BitbucketCloudRessourceTest',
	#superclass : 'TestCase',
	#category : 'BitbucketCloudPharoAPI-Tests',
	#package : 'BitbucketCloudPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketCloudRessourceTest >> testGetAllWithParams [

	"Given"
	| hostUrl client endpoint params objectId object bitbucketRessource result response bitbucketCloudApi |
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketCloudApi := BitbucketCloudApi new
		                accessToken: 'token';
		                host: hostUrl;
		                client: client.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	objectId := 1.
	object := { (#id -> objectId) } asDictionary.

	bitbucketRessource := BitbucketCloudRessource new bitbucketCloudApi: 
		                      bitbucketCloudApi.
		
		
	response := { #values -> { object } } asDictionary.
	client stub get willReturn: (NeoJSONWriter toString: response).
		

	"When"
	result := bitbucketRessource getAll: endpoint withParams: params.

	"Then"
	self assert: result size equals: 1.
	self assert: result first equals: object
]

{ #category : 'tests' }
BitbucketCloudRessourceTest >> testGetWithParams [

	| hostUrl result client object endpoint params bitbucketRessource bitbucketCloudApi |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketCloudApi := BitbucketCloudApi new
		             accessToken: 'token';
		             host: hostUrl;
		             client: client.

	endpoint := '/endpoint'.
	params := { ('param' -> 'value') } asDictionary.

	object := { (#id -> 1) } asDictionary.

	bitbucketRessource := BitbucketCloudRessource new bitbucketCloudApi: bitbucketCloudApi.

	client stub get willReturn: (NeoJSONWriter toString: object).

	"When"
	result := bitbucketRessource get: endpoint withParams: params.

	"Then"
	self assert: result equals: object.
	params keysAndValuesDo: [ :key :value |
		self assert: (client request url query at: key) equals: value ]
]

{ #category : 'tests' }
BitbucketCloudRessourceTest >> testPostJsonWithData [

| hostUrl result client endpoint gitlabRessource data responseMessage response bitbucketApi |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketCloudApi new
		             accessToken: 'token';
		             host: hostUrl;
		             client: client.

	endpoint := '/endpoint'.
	data := { ('param' -> 'value') } asDictionary.

	responseMessage := 'success'.
	response := '{ "message": "' , responseMessage , '" }'.

	gitlabRessource := BitbucketCloudRessource new bitbucketCloudApi: bitbucketApi.

	client stub post willReturn: response.

	"When"
	result := gitlabRessource postJson: endpoint withData: data.

	"Then"
	self assert: (result at: #message) equals: responseMessage.
	self
		assert: client request entity contentType asString
		equals: 'application/json'.
	self
		assert: client request entity string
		equals: (NeoJSONWriter toString: data)
]

{ #category : 'tests' }
BitbucketCloudRessourceTest >> testPostWithData [

| hostUrl result client endpoint gitlabRessource data responseMessage response bitbucketApi |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketCloudApi new
							username: 'username';
		                apiToken: 'token';
		                host: hostUrl;
		                client: client.

	endpoint := '/endpoint'.
	data := { ('param' -> 'value') } asDictionary.

	responseMessage := 'success'.
	response := '{ "message": "' , responseMessage , '" }'.

	gitlabRessource := BitbucketCloudRessource new bitbucketCloudApi: bitbucketApi.

	client stub post willReturn: response.

	"When"
	result := gitlabRessource post: endpoint withData: data.

	"Then"
	self assert: (result at: #message) equals: responseMessage.

	client request entity parts doWithIndex: [ :part :index |
		self assert: part fieldName equals: (data keys at: index).

		self assert: part fieldValue equals: (data values at: index) ]
]

{ #category : 'tests' }
BitbucketCloudRessourceTest >> testPostWithDataIfResponseIsNil [

	| hostUrl result client endpoint gitlabRessource data responseMessage response bitbucketApi |
	"Given"
	hostUrl := 'https://www.url.com'.
	client := ZnClient new.

	bitbucketApi := BitbucketCloudApi new
		                username: 'username';
		                apiToken: 'token';
		                host: hostUrl;
		                client: client.

	endpoint := '/endpoint'.
	data := { ('param' -> 'value') } asDictionary.

	responseMessage := 'success'.
	response := nil.

	gitlabRessource := BitbucketCloudRessource new bitbucketCloudApi:
		                   bitbucketApi.

	client stub post willReturn: response.
	
	client stub response willReturn: (ZnResponse statusCode: 201).

	"When"
	result := gitlabRessource post: endpoint withData: data.

	"Then"
	self assert: (result) equals: 201.

	client request entity parts doWithIndex: [ :part :index |
		self assert: part fieldName equals: (data keys at: index).

		self assert: part fieldValue equals: (data values at: index) ]
]
