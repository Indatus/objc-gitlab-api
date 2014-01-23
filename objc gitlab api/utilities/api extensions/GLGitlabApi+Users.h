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

/**
 *  Get users from GitLab
 *
 *  @param pageNumber   The page of records to get
 *  @param batchSize    The size of the set
 *  @param successBlock Block to execute upon successfully fetching the user
 *  @param failureBlock Block to execute upon failing to fetch the user
 *
 *  @return The operation that will carry out the request
 */
- (GLNetworkOperation *)getUsers:(int64_t)pageNumber
                       batchSize:(int64_t)batchSize
                         success:(GLGitlabSuccessBlock)successBlock
                         failure:(GLGitlabFailureBlock)failureBlock;
/**
 *  Retrieves a single user from gitlab
 *
 *  @param userId       The ID of the user to fetch
 *  @param successBlock Block to execute upon successfully fetching the user
 *  @param failureBlock Block to execute upon failing to fetch the user
 *
 *  @return The operation that will carry out the request
 */
- (GLNetworkOperation *)getUser:(int64_t)userId
                        success:(GLGitlabSuccessBlock)successBlock
                        failure:(GLGitlabFailureBlock)failureBlock;

/**
 *  Creates a user on GitLab, this method is only available for admin users
 *
 *  @param user         The user to be created
 *  @param successBlock Block to execute upon successful creation
 *  @param failureBlock Block to execute upon failed creation
 *
 *  @return The operation that will carry out the request
 */
- (GLNetworkOperation *)createUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock;

/**
 *  Updates a user with its current data, this method is only available for admin users
 *
 *  @param user         The User to be updated
 *  @param successBlock Block to execute upon successful update
 *  @param failureBlock Block to execute upon failed update
 *
 *  @return The operation that will carry out the request
 */
- (GLNetworkOperation *)updateUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock;

/**
 *  Deletes a user from gitlab, this method is only available for admin users
 *
 *  @param user         The User to be deleted
 *  @param successBlock Block to execute upon successful deletion
 *  @param failureBlock Block to execute upon failed deletion
 *
 *  @return The operation that will carry out the request
 */
- (GLNetworkOperation *)deleteUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock;
@end
