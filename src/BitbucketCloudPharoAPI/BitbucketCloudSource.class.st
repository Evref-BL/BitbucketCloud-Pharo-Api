Class {
	#name : 'BitbucketCloudSource',
	#superclass : 'BitbucketCloudRessource',
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'api - post' }
BitbucketCloudSource >> createCommit: sourceCommit inRepository: repoSlug ofWorkspace: workspace [
	"https://developer.atlassian.com/cloud/bitbucket/rest/api-group-source/#api-repositories-workspace-repo-slug-src-post"

	| endpoint |
	endpoint := '/repositories/' , workspace , '/' , repoSlug , '/src'.

	^ self post: endpoint withData: sourceCommit asDictionary
]

{ #category : 'api - get' }
BitbucketCloudSource >> getFileOrDirectory: path fromCommit: commit inRepository: repoSlug ofWorkspace: workspace [

	^ self
		  getFileOrDirectory: path
		  fromCommit: commit
		  inRepository: repoSlug
		  ofWorkspace: workspace
		  withParams: Dictionary new
]

{ #category : 'api - get' }
BitbucketCloudSource >> getFileOrDirectory: path fromCommit: commit inRepository: repoSlug ofWorkspace: workspace withParams: paramsDict [

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
