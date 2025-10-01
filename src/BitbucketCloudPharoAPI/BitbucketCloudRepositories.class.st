Class {
	#name : 'BitbucketCloudRepositories',
	#superclass : 'BitbucketCloudRessource',
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'api - get' }
BitbucketCloudRepositories >> getFileOrDirectory: path fromCommit: commit inRepository: repoSlug ofWorkspace: workspace [
	^self getFileOrDirectory: path fromCommit: commit inRepository: repoSlug ofWorkspace: workspace withParams: Dictionary new
]

{ #category : 'api - get' }
BitbucketCloudRepositories >> getFileOrDirectory: path fromCommit: commit inRepository: repoSlug ofWorkspace: workspace withParams: paramsDict [

	| endpoint metadata pathType currentOutput result |
	endpoint := '/repositories/' , workspace , '/' , repoSlug , '/src/'
	            , commit , '/' , path.

	metadata := self
		            get: endpoint
		            withParams: { (#format -> 'meta') } asDictionary.

	pathType := metadata at: #type.
	pathType = 'commit_directory' ifTrue: [
		^ self getAll: endpoint withParams: paramsDict ].

	currentOutput := bitbucketCloudApi output.
	bitbucketCloudApi output: 'default'.
	result := self get: endpoint withParams: paramsDict.
	bitbucketCloudApi output: currentOutput.

	^ result
]
