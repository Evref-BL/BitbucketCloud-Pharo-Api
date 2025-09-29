# BitbucketCloud-Pharo-Api

[![Continuous](https://github.com/Evref-BL/BitbucketCloud-Pharo-API/actions/workflows/continuous.yml/badge.svg)](https://github.com/Evref-BL/BitbucketCloud-Pharo-API/actions/workflows/continuous.yml)
[![Coverage Status](https://coveralls.io/repos/github/Evref-BL/BitbucketCloud-Pharo-API/badge.svg?branch=develop)](https://coveralls.io/github/Evref-BL/BitbucketCloud-Pharo-API?branch=develop)

A Pharo client for the [Bitbucket Cloud REST API](https://developer.atlassian.com/cloud/bitbucket/rest/intro)

If you are looking for a client targeting Bitbucket Server instead, check out: [Bitbucket-Pharo-API](https://github.com/Evref-BL/Bitbucket-Pharo-API).

## Usage

### Installation

#### From playground

```st
Metacello new
  githubUser: 'Evref-BL' project: 'BitbucketCloud-Pharo-API' commitish: 'main' path: 'src';
  baseline: 'BitbucketCloudPharoAPI';
  onConflict: [ :ex | ex useIncoming ];
  load
```

#### Baseline dependency

```st
  spec
    baseline: 'BitbucketCloudPharoAPI' with: [
      spec repository: 'github://Evref-BL/BitbucketCloud-Pharo-API:main'
    ]
```

### Client

To start using the API, create a BitbucketCloudApi client instance. The API supports two authentication methods: access token or API token (with username).


#### Using an Access Token
```st
bitbucketCloudApi := BitbucketCloudApi new
  host: 'api.bitbucket.org';
  accessToken: '<your-access-token>'.
```

#### Using an API Token
```st
bitbucketCloudApi := BitbucketCloudApi new
  host: 'api.bitbucket.org';
  username: '<your-email>';
  apiToken: '<your-api-token>'.
```

### Ressources

The API provides different resource classes to interact with different entities in Bitbucket. These resources include:

- pullRequests
- refs
- repositories
- source

Each resource provides methods for interacting with the corresponding Bitbucket resource. You can access them like this:

```st
bitbucketCloudApi repositories <method>
```

### Example

Here are a few examples of how to interact with the API:

#### Retrieve a Pull Request

Fetch a pull request by ID within a repository and workspace:

```st
| pullRequest |
pullRequest := bitbucketCloudApi pullRequests get: <pullRequestId> inRepository: '<repoSlug>' ofWorkspace: '<workspace>'.
```

#### List Files and Directories in a Repository

Retrieve files/directories in a repository branch with parameters (e.g., depth):

```st
| commits params |
params := { 
	'max_depth' -> '10'
} asDictionary.
bitbucketCloudApi repositories getFileOrDirectory: '' fromCommit: '<branchName>' inRepository: '<repoSlug>' ofWorkspace: '<workspace>' withParams: params.
```

#### Create a commit 

Create a commit on a branch (only works with API token authentication):

```st
| commits params |
commit := BitbucketCloudSourceCommit new
  message: 'Update README';
  branch: 'dev';
  addFile: 'README.md' withNewContent: 'This is my updated README content.'.

bitbucketCloudApi source createCommit: commit inRepository: '<repoSlug>' ofWorkspace: '<workspace>'.
```