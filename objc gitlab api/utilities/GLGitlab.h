//
//  GLGitlab.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GLGitlabSuccessBlock)(id responseObject);
typedef void (^GLGitlabFailureBlock)(NSError *error);

@class GLNetworkOperation, GLUser, GLMergeRequest, GLProject, GLNote, GLDiff, GLCommit, GLNamespace, GLIssue, GLMilestone;

@interface GLGitlab : NSObject

+ (GLGitlab *)sharedInstance;

- (NSDateFormatter *)gitLabDateFormatter;
- (GLNetworkOperation *)loginToHost:(NSString *)host
                           username:(NSString *)username
                           password:(NSString *)password
                            success:(GLGitlabSuccessBlock)successBlock
                            failure:(GLGitlabFailureBlock)failureBlock;

#pragma mark - Merge Request Methods
- (GLNetworkOperation *)getMergeRequestsForProjectId:(int64_t)projectId
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getMergeRequestWithId:(int64_t)mergeRequestId
                                 successBlock:(GLGitlabSuccessBlock)success
                              andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)createMergeRequestForProjectId:(int64_t)projectId
                                      withMergeRequest:(GLMergeRequest *)mergeRequest
                                          successBlock:(GLGitlabSuccessBlock)success
                                       andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)updateMergeRequestForProjectId:(int64_t)projectId
                                      withMergeRequest:(GLMergeRequest *)mergeRequest
                                          successBlock:(GLGitlabSuccessBlock)success
                                       andFailureBlock:(GLGitlabFailureBlock)failure;

#pragma mark - Notes Methods
// Project/wall notes
- (GLNetworkOperation *)getWallNotesForProjectId:(int64_t)projectId
                                withSuccessBlock:(GLGitlabSuccessBlock)success
                                 andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getWallNoteWithId:(int64_t)noteId
                             forProjectId:(int64_t)projectId
                         withSuccessBlock:(GLGitlabSuccessBlock)success
                          andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)createWallNoteForProjectId:(int64_t)projectId
                                          withBody:(NSString *)body
                                      successBlock:(GLGitlabSuccessBlock)success
                                   andFailureBlock:(GLGitlabFailureBlock)failure;
// Issue notes
- (GLNetworkOperation *)getAllNotesForIssueId:(int64_t)issueId
                             withSuccessBlock:(GLGitlabSuccessBlock)success
                              andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getIssueNoteWithId:(int64_t)noteId
                                forIssueId:(int64_t)issueId
                          withSuccessBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)createNoteForIssueId:(int64_t)issueId
                                    withBody:(NSString *)body
                                successBlock:(GLGitlabSuccessBlock)success
                             andFailureBlock:(GLGitlabFailureBlock)failure;
// Merge request notes
- (GLNetworkOperation *)getAllNotesForMergeRequestId:(int64_t)mergeRequestId
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getNoteWithId:(int64_t)noteId
                    forMergeRequestId:(int64_t)mergeRequestId
                     withSuccessBlock:(GLGitlabSuccessBlock)success
                      andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)createNoteForMergeRequestId:(int64_t)mergeRequestId
                                           withBody:(NSString *)body
                                       successBlock:(GLGitlabSuccessBlock)success
                                    andFailureBlock:(GLGitlabFailureBlock)failure;

#pragma mark - Issues Methods

- (GLNetworkOperation *)getAllIssuesWithSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getAllIssuesForProjectId:(int64_t)projectId
                                withSuccessBlock:(GLGitlabSuccessBlock)success
                                 andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getIssueWithId:(int64_t)issueId
                          forProjectId:(int64_t)projectId
                      withSuccessBlock:(GLGitlabSuccessBlock)success
                       andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)createIssue:(GLIssue *)issue
                       forProjectId:(int64_t)projectId
                   withSuccessBlock:(GLGitlabSuccessBlock)success
                    andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)updateIssue:(GLIssue *)issue
                   withSuccessBlock:(GLGitlabSuccessBlock)success
                    andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)closeIssue:(GLIssue *)issue
                  withSuccessBlock:(GLGitlabSuccessBlock)success
                   andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)reopenIssue:(GLIssue *)issue
                   withSuccessBlock:(GLGitlabSuccessBlock)success
                    andFailureBlock:(GLGitlabFailureBlock)failure;

#pragma mark - Milestone Methods

- (GLNetworkOperation *)getAllMilestonesForProjectId:(int64_t)projectId
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getMilestoneWithId:(int64_t)milestoneId
                              forProjectId:(int64_t)projectId
                          withSuccessBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)createMilestone:(GLMilestone *)milestone forProjectId:(int64_t)projectId
                                   withSuccessBlock:(GLGitlabSuccessBlock)success
                                    andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)updateMilestone:(GLMilestone *)milestone
                       withSuccessBlock:(GLGitlabSuccessBlock)success
                        andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)closeMilestone:(GLMilestone *)milestone
                       withSuccessBlock:(GLGitlabSuccessBlock)success
                        andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)activateMilestone:(GLMilestone *)milestone
                       withSuccessBlock:(GLGitlabSuccessBlock)success
                        andFailureBlock:(GLGitlabFailureBlock)failure;

#pragma mark - Commit Methods

- (GLNetworkOperation *)getAllCommitsForProjectId:(int64_t)projectId
                                 withSuccessBlock:(GLGitlabSuccessBlock)success
                                  andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getCommitWithSha:(NSString *)sha forProjectId:(int64_t)projectId
                        withSuccessBlock:(GLGitlabSuccessBlock)success
                         andFailureBlock:(GLGitlabFailureBlock)failure;

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
 *  Creates a project for the specified user, can only be used by an admin
 *
 *  @param projectName  The name for the new project
 *  @param user         The user from whom the project will be created
 *  @param successBlock parameter will be the newly created Project
 *  @param failureBlock parameter will be an NSError
 *
 *  @return The operation to be executed
 */
- (GLNetworkOperation *)createProjectNamed:(NSString *)projectName
                                   forUser:(GLUser *)user
                                   success:(GLGitlabSuccessBlock)successBlock
                                   failure:(GLGitlabFailureBlock)failureBlock;


@end
