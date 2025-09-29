Class {
	#name : 'BitbucketCloudSourceCommit',
	#superclass : 'Object',
	#instVars : [
		'message',
		'branch',
		'files'
	],
	#category : 'BitbucketCloudPharoAPI',
	#package : 'BitbucketCloudPharoAPI'
}

{ #category : 'adding' }
BitbucketCloudSourceCommit >> addFile: fileName withNewContent: content [
	files add: (fileName -> content)
]

{ #category : 'converting' }
BitbucketCloudSourceCommit >> asDictionary [
	| dictionary |
	dictionary := Dictionary new.
	
	message ifNotNil: [ dictionary at: #message put: message ].
	branch ifNotNil: [ dictionary at: #branch put: branch ].
	
files do: [ :file | 
	dictionary at: file key put: file value
	
 ].

	^dictionary
]

{ #category : 'accessing' }
BitbucketCloudSourceCommit >> branch: anObject [

	branch := anObject
]

{ #category : 'initialization' }
BitbucketCloudSourceCommit >> initialize [ 
	files := OrderedCollection new.
]

{ #category : 'accessing' }
BitbucketCloudSourceCommit >> message: anObject [

	message := anObject
]
