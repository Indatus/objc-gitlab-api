//
//  GLGitlabApi+MergeRequest.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"

@class GLMergeRequest;

@interface GLGitlabApi (MergeRequest)
- (GLNetworkOperation *)getMergeRequestsForProjectId:(int64_t)projectId
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)getMergeRequestWithId:(int64_t)mergeRequestId
                                    projectId:(int64_t)projectId
                                 successBlock:(GLGitlabSuccessBlock)success
                              andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)createMergeRequest:(GLMergeRequest *)mergeRequest
                          withSuccessBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)updateMergeRequest:(GLMergeRequest *)mergeRequest
                              successBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)closeMergeRequest:(GLMergeRequest *)mergeRequest
                              successBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)createComment:(NSString *)comment
                      forMergeRequest:(GLMergeRequest *)mergeRequest
                     withSuccessBlock:(GLGitlabSuccessBlock)success
                      andFailureBlock:(GLGitlabFailureBlock)failure;

@end
