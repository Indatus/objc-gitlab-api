//
//  GLGitlabApi+Files.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"

@interface GLGitlabApi (Files)

- (GLNetworkOperation *)getRepositoryTreeForProjectId:(int64_t)projectId
                                                 path:(NSString *)path
                                           branchName:(NSString *)branch
                                     withSuccessBlock:(GLGitlabSuccessBlock)success
                                      andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)getFileContentFromProject:(int64_t)projectId
                                              sha:(NSString *)sha
                                 withSuccessBlock:(GLGitlabSuccessBlock)success
                                  andFailureBlock:(GLGitlabFailureBlock)failure;


@end
