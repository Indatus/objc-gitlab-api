//
//  GLGitlabApi+Projects.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Projects.h"
#import "GLGitlabApi+Private.h"
#import "GLProject.h"
#import "GLUser.h"
#import "GLEvent.h"

static NSString * const kProjectEndpoint = @"/projects";
static NSString * const kProjectOwnedProjectsEndPoint = @"/projects/owned";
static NSString * const kProjectAllProjectsEndPoint = @"/projects/all";
static NSString * const kProjectSingleProjectEndPoint = @"/projects/%llu";
static NSString * const kProjectEndpointForUser = @"/projects/user/%llu";
static NSString * const kProjectEventsEndPoint = @"/projects/%llu/events";

@implementation GLGitlabApi (Projects)
#pragma mark - Project Methods

- (GLNetworkOperation *)getUsersProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                        failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:kProjectEndpoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *projects = [self processJsonArray:responseObject class:[GLProject class]];
        successBlock(projects);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getUsersOwnedProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                             failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:kProjectOwnedProjectsEndPoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *projects = [self processJsonArray:responseObject class:[GLProject class]];
        successBlock(projects);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getAllProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                      failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:kProjectAllProjectsEndPoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *projects = [self processJsonArray:responseObject class:[GLProject class]];
        successBlock(projects);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getProjectWithId:(int64_t)projectId
                                 success:(GLGitlabSuccessBlock)successBlock
                                 failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kProjectSingleProjectEndPoint, projectId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLProject class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getProjectEventsForProject:(GLProject *)project
                                           success:(GLGitlabSuccessBlock)successBlock
                                           failure:(GLGitlabFailureBlock)failureBlock
{
    return [self getProjectEventsForProjectId:project.projectId
                                      success:successBlock
                                      failure:failureBlock];
}

- (GLNetworkOperation *)getProjectEventsForProjectId:(int64_t)projectId
                                             success:(GLGitlabSuccessBlock)successBlock
                                             failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kProjectEventsEndPoint, projectId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *events = [self processJsonArray:responseObject class:[GLEvent class]];
        successBlock(events);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createProjectNamed:(NSString *)projectName
                                   success:(GLGitlabSuccessBlock)successBlock
                                   failure:(GLGitlabFailureBlock)failureBlock
{
    GLProject *project = [GLProject new];
    project.name = projectName;
    
    return [self createProject:project
                       success:successBlock
                       failure:failureBlock];
}

- (GLNetworkOperation *)createProject:(GLProject *)project
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:kProjectEndpoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationPostMethod;
    request.HTTPBody = [self urlEncodeParams:[project jsonCreateRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLProject class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}


- (GLNetworkOperation *)createProjectNamed:(NSString *)projectName
                                   forUser:(GLUser *)user
                                   success:(GLGitlabSuccessBlock)successBlock
                                   failure:(GLGitlabFailureBlock)failureBlock
{
    GLProject *project = [GLProject new];
    project.name = projectName;
    
    return [self createProject:project
                       forUser:user
                       success:successBlock
                       failure:failureBlock];
}

- (GLNetworkOperation *)createProject:(GLProject *)project
                              forUser:(GLUser *)user
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kProjectEndpointForUser, user.userId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationPostMethod;
    request.HTTPBody = [self urlEncodeParams:[project jsonCreateRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLProject class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];}


@end
