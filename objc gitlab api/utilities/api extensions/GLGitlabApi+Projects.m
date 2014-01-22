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

@implementation GLGitlabApi (Projects)
#pragma mark - Project Methods

- (GLNetworkOperation *)getUsersProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                        failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getUsersOwnedProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                             failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getAllProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                      failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getProjectWithId:(int64_t)projectId
                                 success:(GLGitlabSuccessBlock)successBlock
                                 failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
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
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createProjectNamed:(NSString *)projectName
                                   success:(GLGitlabSuccessBlock)successBlock
                                   failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createProjectNamed:(NSString *)projectName
                                   forUser:(GLUser *)user
                                   success:(GLGitlabSuccessBlock)successBlock
                                   failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end
