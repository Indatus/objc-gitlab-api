//
//  GLGitlabApi+Milestones.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Milestones.h"
#import "GLGitlabApi+Private.h"
#import "GLMilestone.h"

// Endpoints
static NSString * const kMilestonesEndpoint = @"/projects/%llu/milestones";
static NSString * const kSingleMilestoneEndpoint = @"/projects/%llu/milestones/%llu";

@implementation GLGitlabApi (Milestones)
#pragma mark - Milestone Methods

- (GLNetworkOperation *)getAllMilestonesForProjectId:(int64_t)projectId
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kMilestonesEndpoint, projectId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self multipleObjectSuccessBlockForClass:[GLMilestone class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getMilestoneWithId:(int64_t)milestoneId
                              forProjectId:(int64_t)projectId
                          withSuccessBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleMilestoneEndpoint, projectId, milestoneId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLMilestone class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createMilestone:(GLMilestone *)milestone
                       withSuccessBlock:(GLGitlabSuccessBlock)success
                        andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleMilestoneEndpoint, milestone.projectId, milestone.milestoneId]
                                                     method:GLNetworkOperationPostMethod];
    request.HTTPBody = [self urlEncodeParams:[milestone jsonCreateRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLMilestone class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)updateMilestone:(GLMilestone *)milestone
                       withSuccessBlock:(GLGitlabSuccessBlock)success
                        andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleMilestoneEndpoint, milestone.projectId, milestone.milestoneId]
                                                     method:GLNetworkOperationPutMethod];
    request.HTTPBody = [self urlEncodeParams:[milestone jsonRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLMilestone class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)closeMilestone:(GLMilestone *)milestone
                      withSuccessBlock:(GLGitlabSuccessBlock)success
                       andFailureBlock:(GLGitlabFailureBlock)failure
{
    milestone.state = @"closed";
    
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleMilestoneEndpoint, milestone.projectId, milestone.milestoneId]
                                                     method:GLNetworkOperationPutMethod];
    request.HTTPBody = [self urlEncodeParams:[milestone jsonRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLMilestone class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)activateMilestone:(GLMilestone *)milestone
                         withSuccessBlock:(GLGitlabSuccessBlock)success
                          andFailureBlock:(GLGitlabFailureBlock)failure
{
    milestone.state = @"active";

    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleMilestoneEndpoint, milestone.projectId, milestone.milestoneId]
                                                     method:GLNetworkOperationPutMethod];
    request.HTTPBody = [self urlEncodeParams:[milestone jsonRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLMilestone class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}


@end
