objc-gitlab-api : An Objective-C Gitlab Wrapper
===============================================

## Installation with CocoaPods

<hr/>

To include this library just add the following to your projects Podfile.

```
pod 'ObjcGitlabApi', '~> 1.0'
```

## Usage

<hr/>

All of the calls to the API are executed from the singleton ```GLGitlabApi``` which uses blocks for the callbacks on each request.  Each call returns the operation that it begins so that it maybe cancled if necessary.

### Login

Loging in will return the information for the user that the login is requeted for. 

```objective-c
[[GLGitlabApi sharedInstance] loginToHost:@"http://gitlab.example.com"
								 username:@"exampleuser"
				 				 password:@"password"
				  				  success:^(GLUser *user) {
									  	// Perform additional work here
									}
								  failure:^(NSError *error) {
								  		// Handle login failure
				  					}];
```

### Fetching projects

To get all projects for a user you would use the following method.

```objective-c
[[GLGitlabApi sharedInstance] getUsersProjectsSuccess:^(NSArray *projects) {
											// Process projects
										}
					       				       failure:^(NSError *error) {
											// Handle error
										}];
```

Fetch details about a project

```objective-c
[[GLGitlabApi sharedInstance] getProjectWithId:1
  	                                   success:^(GLProject *project) {
		                                 // Perform additional work here
        		                     }
                	                   failure:^(NSError *error) {
                                 		// Handle error here
		                             }];
```

The remaining calls in the api follow a similar pattern