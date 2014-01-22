//
//  GLGitlabApi+Users.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"

@class GLUser;

@interface GLGitlabApi (Users)

- (GLNetworkOperation *)getUsers:(ino64_t)pageNumber
                       batchSize:(int64_t)batchSize
                         success:(GLGitlabSuccessBlock)successBlock
                         failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)getUser:(ino64_t)userId
                        success:(GLGitlabSuccessBlock)successBlock
                        failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)createUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)updateUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock;

- (GLNetworkOperation *)deleteUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock;
@end
