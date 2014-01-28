//
//  GLGitlabApi+Repositories.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"

@class GLProject, GLBranch;

@interface GLGitlabApi (Repositories)

- (GLNetworkOperation *)getRepoBranchesForProject:(GLProject *)project
                                          success:(GLGitlabSuccessBlock)successBlock
                                          failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)getBranchNamed:(NSString *)branchName
                             inProject:(GLProject *)project
                               success:(GLGitlabSuccessBlock)successBlock
                               failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)protectBranch:(GLBranch *)branch
                            inProject:(GLProject *)project
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)unprotectBranch:(GLBranch *)branch
                              inProject:(GLProject *)project
                                success:(GLGitlabSuccessBlock)successBlock
                                failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)getTagsForProject:(GLProject *)project
                                  success:(GLGitlabSuccessBlock)successBlock
                                  failure:(GLGitlabFailureBlock)failureBlock;
@end
