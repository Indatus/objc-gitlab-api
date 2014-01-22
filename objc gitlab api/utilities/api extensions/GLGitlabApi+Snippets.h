//
//  GLGitlabApi+Snippets.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"


@class GLSnippet;

@interface GLGitlabApi (Snippets)

- (GLNetworkOperation *)getSnippetsForProjectId:(int64_t)projectId
                                        success:(GLGitlabSuccessBlock)successBlock
                                        failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)getSnippet:(int64_t)snippetId
                         projectId:(int64_t)projectId
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)createSnippet:(GLSnippet *)snippet
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)updateSnippet:(GLSnippet *)snippet
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)deleteSnippet:(GLSnippet *)snippet
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)getRawSnippet:(GLSnippet *)snippet
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock;
@end
