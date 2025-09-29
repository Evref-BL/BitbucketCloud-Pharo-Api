Class {
	#name : 'BitbucketCloudRefs',
	#superclass : 'BitbucketCloudRessource',
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'api - post' }
BitbucketCloudRefs >> createBranch: branchName fromHash: hash inRepository: repoSlug ofWorkspace: workspace [
	"https://developer.atlassian.com/cloud/bitbucket/rest/api-group-refs/#api-repositories-workspace-repo-slug-refs-branches-post"
	
	| endpoint data |
	endpoint := '/repositories/', workspace, '/',repoSlug, '/refs/branches'.
	
	data := { 
		#name -> branchName.
		#target -> { 
			#hash -> hash 
		} asDictionary
	} asDictionary.
	
	^self postJson: endpoint withData: data.
]
