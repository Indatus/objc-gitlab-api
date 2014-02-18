//
// Created by Jeff Trespalacios on 2/13/14.
// Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Groups.h"
#import "GLGitlabApi+Private.h"
#import "GLGroup.h"
#import "GLProject.h"

static NSString * const kGroupsEndpoint = @"/groups";
static NSString * const kGroupEndpoint = @"/groups/%lld";
static NSString * const kProjectsKey = @"projects";

@implementation GLGitlabApi (Groups)

- (GLNetworkOperation *)getUsersGroupsWithSuccessBlock:(GLGitlabSuccessBlock)success
                                       andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSURL *url = [self requestUrlForEndPoint:kGroupsEndpoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;

    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *groups = [self processJsonArray:responseObject class:[GLGroup class]];
        success(groups);
    };

    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];

    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getDetailsGroup:(int64_t)groupId
                           SuccessBlock:(GLGitlabSuccessBlock)success
                        andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kGroupEndpoint, groupId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        NSArray *projectsJson = responseObject[kProjectsKey];
        NSArray *projects = [self processJsonArray:projectsJson class:[GLProject class]];
        success(projects);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end