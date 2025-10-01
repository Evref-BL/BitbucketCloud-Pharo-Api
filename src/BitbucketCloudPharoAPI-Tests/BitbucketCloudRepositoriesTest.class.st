"
A BitbucketCloudRepositoriesTest is a test class for testing the behavior of BitbucketCloudRepositories
"
Class {
	#name : 'BitbucketCloudRepositoriesTest',
	#superclass : 'TestCase',
	#category : 'BitbucketCloudPharoAPI-Tests',
	#package : 'BitbucketCloudPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketCloudRepositoriesTest >> testGetFileOrDirectoryFromCommitInRepositoryOfWorkspace [

	| hostUrl client bitbucketApi endpoint response result bitbucketRepos workspace repoSlug commit path params getResponse |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketCloudApi new
		                accessToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketRepos := BitbucketCloudRepositories new bitbucketCloudApi:
		                  bitbucketApi.

	workspace := 'OOO'.
	repoSlug := 'slug'.
	commit := 'dev'.
	path := ''.


	endpoint := '/repositories/' , workspace , '/' , repoSlug , '/src/'
	            , commit , '/' , path.

	response := { (#file1 -> '1') } asDictionary.
	
	params := { 
		#format -> 'meta'
	} asDictionary.
	
	getResponse := { 
		#type -> 'commit_directory'
	}  asDictionary.
	(bitbucketRepos stub get: endpoint withParams: params) willReturn: getResponse.

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
BitbucketCloudRepositoriesTest >> testGetFileOrDirectoryFromCommitInRepositoryOfWorkspaceWithParams [

	| hostUrl client bitbucketApi endpoint response result bitbucketRepos workspace repoSlug commit path params getResponse |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketCloudApi new
		                accessToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketRepos := BitbucketCloudRepositories new bitbucketCloudApi:
		                  bitbucketApi.

	workspace := 'OOO'.
	repoSlug := 'slug'.
	commit := 'dev'.
	path := ''.

	params := { (#max_depth -> 10) } asDictionary.

	endpoint := '/repositories/' , workspace , '/' , repoSlug , '/src/'
	            , commit , '/' , path.

	response := { (#file1 -> '1') } asDictionary.
	
	
	params := { 
		#format -> 'meta'
	} asDictionary.
	
	getResponse := { 
		#type -> 'commit_directory'
	}  asDictionary.
	(bitbucketRepos stub get: endpoint withParams: params) willReturn: getResponse.

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
BitbucketCloudRepositoriesTest >> testGetFileOrDirectoryFromCommitInRepositoryOfWorkspaceWithParamsIfFile [

	| hostUrl client bitbucketApi endpoint response result bitbucketRepos workspace repoSlug commit path params getResponse metaParams |
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketCloudApi new
		                accessToken: 'token';
		                host: hostUrl;
		                client: client.

	bitbucketRepos := BitbucketCloudRepositories new bitbucketCloudApi:
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
