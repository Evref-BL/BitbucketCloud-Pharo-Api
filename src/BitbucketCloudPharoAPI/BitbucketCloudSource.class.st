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
