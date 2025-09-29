"
A BitbucketCloudSourceTest is a test class for testing the behavior of BitbucketCloudSource
"
Class {
	#name : 'BitbucketCloudSourceTest',
	#superclass : 'TestCase',
	#category : 'BitbucketCloudPharoAPI-Tests',
	#package : 'BitbucketCloudPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketCloudSourceTest >> testCreateCommitInRepositoryOfWorkspace [

	| hostUrl result client endpoint response bitbucketApi repositorySlug workspace bitbucketSource commit |
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketCloudApi new
		                username: 'username';
		                apiToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketSource := BitbucketCloudSource new bitbucketCloudApi:
		                   bitbucketApi.

	workspace := 'OOO'.
	repositorySlug := 'my-project'.


	commit := BitbucketCloudSourceCommit new
		          message: 'message';
		          branch: 'branch';
		          addFile: 'file.txt' withNewContent: 'content'.

	endpoint := '/repositories/' , workspace , '/' , repositorySlug , '/src'.
	response := { (#message -> 'message') } asDictionary.
	
	commit stub asDictionary willReturn: commit asDictionary.

	(bitbucketSource stub post: endpoint withData: commit asDictionary)
		willReturn: response.

	"When"
	result := bitbucketSource
		          createCommit: commit
		          inRepository: repositorySlug
		          ofWorkspace: workspace.

	"Then"
	self assert: result equals: response
]
