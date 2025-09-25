Class {
	#name : 'BitbucketCloudRessource',
	#superclass : 'Object',
	#instVars : [
		'bitbucketCloudApi'
	],
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'accessing' }
BitbucketCloudRessource >> bitbucketCloudApi: anObject [

	bitbucketCloudApi := anObject
]

{ #category : 'as yet unclassified' }
BitbucketCloudRessource >> get: path withParams: paramsDict [

	| response |
	bitbucketCloudApi prepareClient.
	bitbucketCloudApi client path: bitbucketCloudApi basePath , path.

	paramsDict keysAndValuesDo: [ :key :value |
		bitbucketCloudApi client queryAt: key put: value ].

	response := bitbucketCloudApi client get.

	bitbucketCloudApi output = 'dict' ifTrue: [
		^ NeoJSONReader fromString: response ].

	^ response
]

{ #category : 'as yet unclassified' }
BitbucketCloudRessource >> getAll: endpoint withParams: paramsDict [

	| values results |
	bitbucketCloudApi prepareClient.
	bitbucketCloudApi client path: bitbucketCloudApi basePath , endpoint.

	paramsDict keysAndValuesDo: [ :key :value |
		bitbucketCloudApi client queryAt: key put: value ].

	values := OrderedCollection new.

	[
   |isLastPage|
	results := bitbucketCloudApi client get.
	results := (NeoJSONReader on: results readStream) next.
	values addAll: (results at: #values).
	isLastPage := results at: #next ifPresent: [ :next |
		bitbucketCloudApi client url: next.
		false
	] ifAbsent: [
		true
	].
	isLastPage 
	] whileFalse.

	^ values
]
