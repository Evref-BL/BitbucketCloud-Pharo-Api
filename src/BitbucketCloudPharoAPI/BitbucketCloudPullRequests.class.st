Class {
	#name : 'BitbucketCloudPullRequests',
	#superclass : 'BitbucketCloudRessource',
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'api - post' }
BitbucketCloudPullRequests >> create: pullRequestCreate inRepository: repoSlug ofWorkspace: workspace [
	"https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-repositories-workspace-repo-slug-pullrequests-post"
	
	| endpoint |
	endpoint := '/repositories/', workspace, '/', repoSlug, '/pullrequests'.
	
	^self postJson: endpoint withData: pullRequestCreate asDictionary.
]

{ #category : 'api - get' }
BitbucketCloudPullRequests >> get: pullRequestId inRepository: repoSlug ofWorkspace: workspace [
	"https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-repositories-workspace-repo-slug-pullrequests-pull-request-id-get"
	
	| endpoint |
	endpoint := '/repositories/', workspace , '/', repoSlug, '/pullrequests/', pullRequestId asString.
	
	^self get: endpoint withParams: Dictionary new 
]

{ #category : 'api - get' }
BitbucketCloudPullRequests >> getCommentsOf: pullRequestId inRepository: repoSlug ofWorkspace: workspace [ 
	"https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-repositories-workspace-repo-slug-pullrequests-pull-request-id-comments-get"
	
	| endpoint |
	endpoint := '/repositories/', workspace, '/', repoSlug, '/pullrequests/', pullRequestId asString, '/comments'.
	
	^self getAll: endpoint withParams: Dictionary new.
]

{ #category : 'api - post' }
BitbucketCloudPullRequests >> postComment: bitbucketCloudPullRequestComment inPullRequest: pullRequestId inRepository: repoSlug ofWorkspace: workspace [
	"https://developer.atlassian.com/cloud/bitbucket/rest/api-group-pullrequests/#api-repositories-workspace-repo-slug-pullrequests-pull-request-id-comments-post"
	
	| endpoint |
	endpoint := '/repositories/', workspace, '/', repoSlug, '/pullrequests/', pullRequestId asString , '/comments'.

	^self postJson: endpoint withData: bitbucketCloudPullRequestComment asDictionary.
]
