"
A BitbucketCloudRefsTest is a test class for testing the behavior of BitbucketCloudRefs
"
Class {
	#name : 'BitbucketCloudRefsTest',
	#superclass : 'TestCase',
	#category : 'BitbucketCloudPharoAPI-Tests',
	#package : 'BitbucketCloudPharoAPI-Tests'
}

{ #category : 'tests' }
BitbucketCloudRefsTest >> testCreateBranchFromHashInRepositoryOfWorkspace [

	| hostUrl result client endpoint response bitbucketApi repositorySlug workspace bitbucketRefs branchName fromHash data |
	"Given"
	hostUrl := 'www.url.com'.
	client := Mock new.

	bitbucketApi := BitbucketCloudApi new
		             accessToken: 'token';
		             host: hostUrl;
		             client: client.
	bitbucketRefs := BitbucketCloudRefs new bitbucketCloudApi: bitbucketApi.

	workspace := 'OOO'.
	repositorySlug := 'my-project'.
	branchName := 'test'.
	fromHash := 'dev'.
	
	
	data := { 
		#name -> branchName.
		#target -> { 
			#hash -> fromHash 
		} asDictionary.
	} asDictionary.
	
	endpoint := '/repositories/' , workspace , '/', repositorySlug, '/refs/branches'.
	response := { (#message -> 'message') } asDictionary.

	(bitbucketRefs stub postJson: endpoint withData: data) willReturn:
		response.

	"When"
	result := bitbucketRefs createBranch: branchName fromHash: fromHash inRepository: repositorySlug  ofWorkspace: workspace. 

	"Then"
	self assert: result equals: response
]
