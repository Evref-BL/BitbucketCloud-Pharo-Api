Class {
	#name : 'BitbucketCloudPullRequests',
	#superclass : 'BitbucketCloudRessource',
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'as yet unclassified' }
BitbucketCloudPullRequests >> get: pullRequestId inRepository: repoSlug ofWorkspace: workspace [
	"https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-repositories-workspace-repo-slug-pullrequests-pull-request-id-get"
	
	| endpoint |
	endpoint := '/repositories/', workspace , '/', repoSlug, '/pullrequests/', pullRequestId asString.
	
	^self get: endpoint withParams: Dictionary new 
]
