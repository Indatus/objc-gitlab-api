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

// Endpoints
static NSString * const kMergeRequestEndPoint = @"/merge_requests";

// Parameter Keys
//static NSString * const kParamProjectId = @"

@implementation GLGitlabApi (MergeRequest)
#pragma mark - MergeRequest Methods

- (GLNetworkOperation *)getMergeRequestsForProjectId:(int64_t)projectId
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure
{
//    NSString *endpoint = [self urlEncodeParamsForGet:@{]
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getMergeRequestWithId:(int64_t)mergeRequestId
                                 successBlock:(GLGitlabSuccessBlock)success
                              andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
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
    request.HTTPMethod = GLNetworkOperationPostMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)updateMergeRequest:(GLMergeRequest *)mergeRequest
                              successBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationPutMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createCommentForMergeRequest:(GLMergeRequest *)mergeRequest
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationPostMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end
