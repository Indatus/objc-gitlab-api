//
//  GLGitlabApi+Projects.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"

@class GLProject, GLUser;

@interface GLGitlabApi (Projects)
#pragma mark - Project Methods
/**
 *  Returns all projects a user is associated with
 *
 *  @param successBlock parameter will be an NSArray of GLProject objects
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)getUsersProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                        failure:(GLGitlabFailureBlock)failureBlock;

/**
 *  Returns all projects a user owns
 *
 *  @param successBlock parameter will be an NSArray of GLProject objects
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)getUsersOwnedProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                             failure:(GLGitlabFailureBlock)failureBlock;

/**
 *  Returns all projects, may only be used by an admin user
 *
 *  @param successBlock parameter will be an NSArray of GLProject objects
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)getAllProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                      failure:(GLGitlabFailureBlock)failureBlock;

/**
 *  Retrieves the project with the specified id
 *
 *  @param projectId    ID of the project to be fetched
 *  @param successBlock parameter will be an instance of GLProject
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)getProjectWithId:(int64_t)projectId
                                 success:(GLGitlabSuccessBlock)successBlock
                                 failure:(GLGitlabFailureBlock)failureBlock;

// TODO: Determine returned objects
/**
 *  Retrieves all events for the specified project Id
 *
 *  @param projectId    ID of the project that events should be retrieved for
 *  @param successBlock parameter will be an NSArray of TBD
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)getProjectEventsForProjectId:(int64_t)projectId
                                             success:(GLGitlabSuccessBlock)successBlock
                                             failure:(GLGitlabFailureBlock)failureBlock;

// TODO: Determine returned objects
/**
 *  Retrieves all events for the specified project Id
 *
 *  @param project      The project that events should be retrieved for
 *  @param successBlock parameter will be an NSArray of TBD
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)getProjectEventsForProject:(GLProject *)project
                                           success:(GLGitlabSuccessBlock)successBlock
                                           failure:(GLGitlabFailureBlock)failureBlock;

/**
 *  Retrieve all team members for the specified project
 *
 *  @param projectId    ID of the project that users should be feched for
 *  @param successBlock parameter will be an NSArray of GLUsers
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)getProjectTeamUsers:(int64_t)projectId
                                    success:(GLGitlabSuccessBlock)successBlock
                                    failure:(GLGitlabFailureBlock)failureBlock;

/**
 *  Creates a project with the specified name
 *
 *  @param projectName  The name for the new project
 *  @param successBlock parameter will be the newly created Project
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)createProjectNamed:(NSString *)projectName
                                   success:(GLGitlabSuccessBlock)successBlock
                                   failure:(GLGitlabFailureBlock)failureBlock;

/**
 *  Creates a project with the specified model
 *
 *  @param project      The model of the new project
 *  @param successBlock parameter will be the newly created Project
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)createProject:(GLProject *)project
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock;


/**
 *  Creates a project for the specified user, can only be used by an admin
 *
 *  @param projectName  The name for the new project
 *  @param user         The user for whom the project will be created
 *  @param successBlock parameter will be the newly created Project
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)createProjectNamed:(NSString *)projectName
                                   forUser:(GLUser *)user
                                   success:(GLGitlabSuccessBlock)successBlock
                                   failure:(GLGitlabFailureBlock)failureBlock;

/**
 *  Creates a project for the specified user, can only be used by an admin
 *
 *  @param project      The name for the new project
 *  @param user         The user for whom the project will be created
 *  @param successBlock parameter will be the newly created Project
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)createProject:(GLProject *)project
                              forUser:(GLUser *)user
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock;

@end
