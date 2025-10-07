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

{ #category : 'tests' }
BitbucketCloudSourceTest >> testGetFileOrDirectoryFromCommitInRepositoryOfWorkspace [

	| hostUrl client bitbucketApi endpoint response result bitbucketRepos workspace repoSlug commit path params getResponse |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketCloudApi new
		                accessToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketRepos := BitbucketCloudSource new bitbucketCloudApi:
		                  bitbucketApi.

	workspace := 'OOO'.
	repoSlug := 'slug'.
	commit := 'dev'.
	path := ''.


	endpoint := '/repositories/' , workspace , '/' , repoSlug , '/src/'
	            , commit , '/' , path.

	response := { (#file1 -> '1') } asDictionary.

	params := { (#format -> 'meta') } asDictionary.

	getResponse := { (#type -> 'commit_directory') } asDictionary.
	(bitbucketRepos stub get: endpoint withParams: params) willReturn:
		getResponse.

	(bitbucketRepos stub getAll: endpoint withParams: Dictionary new)
		willReturn: response.

	"When"
	result := bitbucketRepos
		          getFileOrDirectory: path
		          fromCommit: commit
		          inRepository: repoSlug
		          ofWorkspace: workspace.

	"Then"
	self assert: result equals: response
]

{ #category : 'tests' }
BitbucketCloudSourceTest >> testGetFileOrDirectoryFromCommitInRepositoryOfWorkspaceWithParams [

	| hostUrl client bitbucketApi endpoint response result bitbucketRepos workspace repoSlug commit path params getResponse |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketCloudApi new
		                accessToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketRepos := BitbucketCloudSource new bitbucketCloudApi:
		                  bitbucketApi.

	workspace := 'OOO'.
	repoSlug := 'slug'.
	commit := 'dev'.
	path := ''.

	params := { (#max_depth -> 10) } asDictionary.

	endpoint := '/repositories/' , workspace , '/' , repoSlug , '/src/'
	            , commit , '/' , path.

	response := { (#file1 -> '1') } asDictionary.


	params := { (#format -> 'meta') } asDictionary.

	getResponse := { (#type -> 'commit_directory') } asDictionary.
	(bitbucketRepos stub get: endpoint withParams: params) willReturn:
		getResponse.

	(bitbucketRepos stub getAll: endpoint withParams: params)
		willReturn: response.

	"When"
	result := bitbucketRepos
		          getFileOrDirectory: path
		          fromCommit: commit
		          inRepository: repoSlug
		          ofWorkspace: workspace
		          withParams: params.

	"Then"
	self assert: result equals: response
]

{ #category : 'tests' }
BitbucketCloudSourceTest >> testGetFileOrDirectoryFromCommitInRepositoryOfWorkspaceWithParamsIfFile [

	| hostUrl client bitbucketApi endpoint response result bitbucketRepos workspace repoSlug commit path params getResponse metaParams |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketCloudApi new
		                accessToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketRepos := BitbucketCloudSource new bitbucketCloudApi:
		                  bitbucketApi.

	workspace := 'OOO'.
	repoSlug := 'slug'.
	commit := 'dev'.
	path := ''.

	params := { (#max_depth -> 10) } asDictionary.

	endpoint := '/repositories/' , workspace , '/' , repoSlug , '/src/'
	            , commit , '/' , path.

	response := { (#file1 -> '1') } asDictionary.


	metaParams := { (#format -> 'meta') } asDictionary.

	getResponse := { (#type -> 'commit_file') } asDictionary.
	(bitbucketRepos stub get: endpoint withParams: metaParams)
		willReturn: getResponse.
	(bitbucketRepos stub get: endpoint withParams: params) willReturn:
		'text'.

	"When"
	result := bitbucketRepos
		          getFileOrDirectory: path
		          fromCommit: commit
		          inRepository: repoSlug
		          ofWorkspace: workspace
		          withParams: params.

	"Then"
	self assert: result equals: 'text'
]
