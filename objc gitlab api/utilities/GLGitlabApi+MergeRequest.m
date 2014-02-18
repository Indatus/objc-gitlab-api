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
static NSString * const kMergeRequestsEndPoint = @"/projects/%llu/merge_requests";
static NSString * const kSingleMergeRequestEndPoint = @"/projects/%llu/merge_request/%llu";

// API Parameters
static NSString * const kParamComment = @"note";

@implementation GLGitlabApi (MergeRequest)
#pragma mark - MergeRequest Methods

- (GLNetworkOperation *)getMergeRequestsForProjectId:(int64_t)projectId
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kMergeRequestsEndPoint, projectId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self multipleObjectSuccessBlockForClass:[GLMergeRequest class]
                                                                                   successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getMergeRequestWithId:(int64_t)mergeRequestId
                                    projectId:(int64_t)projectId
                                 successBlock:(GLGitlabSuccessBlock)success
                              andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleMergeRequestEndPoint, projectId, mergeRequestId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLMergeRequest class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createMergeRequest:(GLMergeRequest *)mergeRequest
                          withSuccessBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kMergeRequestsEndPoint, mergeRequest.projectId]
                                                     method:GLNetworkOperationPostMethod];
    request.HTTPBody = [self urlEncodeParams:[mergeRequest jsonCreateRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLMergeRequest class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)updateMergeRequest:(GLMergeRequest *)mergeRequest
                              successBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleMergeRequestEndPoint, mergeRequest.projectId, mergeRequest.mergeRequestId]
                                                     method:GLNetworkOperationPutMethod];
    request.HTTPBody = [self urlEncodeParams:[mergeRequest jsonRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLMergeRequest class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)closeMergeRequest:(GLMergeRequest *)mergeRequest
                             successBlock:(GLGitlabSuccessBlock)success
                          andFailureBlock:(GLGitlabFailureBlock)failure
{
    mergeRequest.state = @"closed";
    return [self updateMergeRequest:mergeRequest successBlock:success andFailureBlock:failure];
}


- (GLNetworkOperation *)createComment:(NSString *)comment
                      forMergeRequest:(GLMergeRequest *)mergeRequest
                     withSuccessBlock:(GLGitlabSuccessBlock)success
                      andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kMergeRequestsEndPoint, mergeRequest.projectId]
                                                     method:GLNetworkOperationPostMethod];
    request.HTTPBody = [self urlEncodeParams:@{kParamComment: comment}];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLMergeRequest class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end
