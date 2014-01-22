//
//  GLGitlabApi+MergeRequest.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+MergeRequest.h"
#import "GLGitlabApi+Private.h"
#import "GLMergeRequest.h"

@implementation GLGitlabApi (MergeRequest)
#pragma mark - MergeRequest Methods

- (GLNetworkOperation *)getMergeRequestsForProjectId:(int64_t)projectId
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

- (GLNetworkOperation *)getMergeRequestWithId:(int64_t)mergeRequestId
                                 successBlock:(GLGitlabSuccessBlock)success
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

- (GLNetworkOperation *)createMergeRequestForProjectId:(int64_t)projectId
                                      withMergeRequest:(GLMergeRequest *)mergeRequest
                                          successBlock:(GLGitlabSuccessBlock)success
                                       andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPostMethod;
    
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

- (GLNetworkOperation *)updateMergeRequest:(GLMergeRequest *)mergeRequest
                              successBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPutMethod;
    
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
