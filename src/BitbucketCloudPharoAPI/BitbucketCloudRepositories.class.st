Class {
	#name : 'BitbucketCloudRepositories',
	#superclass : 'BitbucketCloudRessource',
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'as yet unclassified' }
BitbucketCloudRepositories >> getFileOrDirectory: path fromCommit: commit inRepository: repoSlug ofWorkspace: workspace [
	^self getFileOrDirectory: path fromCommit: commit inRepository: repoSlug ofWorkspace: workspace withParams: Dictionary new
]

{ #category : 'as yet unclassified' }
BitbucketCloudRepositories >> getFileOrDirectory: path fromCommit: commit inRepository: repoSlug ofWorkspace: workspace withParams: paramsDict [
	| endpoint |
	endpoint := '/repositories/', workspace, '/', repoSlug, '/src/', commit, '/', path.
	
	^self getAll: endpoint withParams: paramsDict
]
