//
//  GLGitlabApi+Commits.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Commits.h"
#import "GLGitlabApi+Private.h"

@implementation GLGitlabApi (Commits)
#pragma mark - Commit Methods

- (GLNetworkOperation *)getAllCommitsForProjectId:(int64_t)projectId
                                 withSuccessBlock:(GLGitlabSuccessBlock)success
                                  andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}
- (GLNetworkOperation *)getCommitWithSha:(NSString *)sha forProjectId:(int64_t)projectId
                        withSuccessBlock:(GLGitlabSuccessBlock)success
                         andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getCommitDiffWithSha:(NSString *)sha forProjectId:(int64_t)projectId
                            withSuccessBlock:(GLGitlabSuccessBlock)success
                             andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end
