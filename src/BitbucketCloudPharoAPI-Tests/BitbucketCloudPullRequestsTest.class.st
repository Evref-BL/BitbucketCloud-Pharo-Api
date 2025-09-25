"
A BitbucketCloudPullRequestsTest is a test class for testing the behavior of BitbucketCloudPullRequests
"
Class {
	#name : 'BitbucketCloudPullRequestsTest',
	#superclass : 'TestCase',
	#category : 'BitbucketCloudPharoAPI-Tests',
	#package : 'BitbucketCloudPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketCloudPullRequestsTest >> testGetInRepositoryOfWorkspace [

	| hostUrl gitlabApi result client path bitbucketPullRequests pullRequestID repoSlug pullRequest workspace |
	"Given"
	hostUrl := 'www.url.com'.
	client := ZnClient new.

	gitlabApi := BitbucketCloudApi new
		             accessToken: 'token';
		             host: hostUrl;
		             client: client.
	bitbucketPullRequests := BitbucketCloudPullRequests new bitbucketCloudApi: gitlabApi.

	pullRequestID := 24.
	workspace := 'AAA'.
	repoSlug := 'project'.

	pullRequest := { (#id -> pullRequestID) } asDictionary.

	path := '/repositories/' , workspace , '/', repoSlug, '/pullrequests/', pullRequestID asString.
	(bitbucketPullRequests stub get: path withParams: Dictionary new)
		willReturn: pullRequest.

	"When"
	result := bitbucketPullRequests
		          get: pullRequestID
		          inRepository: repoSlug ofWorkspace: workspace.

	"Then"
	self assert: result equals: pullRequest
]

{ #category : 'tests' }
BitbucketCloudPullRequestsTest >> testPostCommentInPullRequestInRepositoryOfWorkspace [

	| hostUrl result client endpoint response bitbucketApi bitbucketPullRequests repositorySlug pullRequestId comment workspace |
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketCloudApi new
		             accessToken: 'token';
		             host: hostUrl;
		             client: client.
	bitbucketPullRequests := BitbucketCloudPullRequests new bitbucketCloudApi: bitbucketApi.

	workspace := 'OOO'.
	repositorySlug := 'my project'.
	pullRequestId := 4.
	
	comment := BitbucketCloudPullRequestComment new 
		rawContent: 'test'.
	
	endpoint := '/repositories/' , workspace , '/', repositorySlug, '/pullrequests/', pullRequestId asString, '/comments'.

	response := { (#message -> 'message') } asDictionary.

	(bitbucketPullRequests stub postJson: endpoint withData: comment asDictionary) willReturn:
		response.

	"When"
	result := bitbucketPullRequests postComment: comment inPullRequest: pullRequestId inRepository: repositorySlug  ofWorkspace: workspace. 

	"Then"
	self assert: result equals: response
]
