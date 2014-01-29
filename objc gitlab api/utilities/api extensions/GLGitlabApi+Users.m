//
//  GLGitlabApi+Users.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Users.h"
#import "GLGitlabApi+Private.h"
#import "GLUser.h"

// End points
static NSString * const kUserEndpoint = @"/users";
static NSString * const kSingleUserEndpoint = @"/users/%llu";

// Parameter Keys
static NSString * const kPageParam = @"page";
static NSString * const kPerPageParam = @"per_page";

@implementation GLGitlabApi (Users)
#pragma mark - User Methods

- (GLNetworkOperation *)getUsers:(int64_t)pageNumber
                       batchSize:(int64_t)batchSize
                         success:(GLGitlabSuccessBlock)successBlock
                         failure:(GLGitlabFailureBlock)failureBlock
{
    NSString *endpoint = [self urlEncodeParamsForGet:@{ kPageParam: @(pageNumber), kPerPageParam: @(batchSize) } endpoint:kUserEndpoint];
    NSURL *url = [self requestUrlForEndPoint:endpoint];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *users = [self processJsonArray:responseObject class:[GLUser class]];
        successBlock(users);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getUser:(int64_t)userId
                        success:(GLGitlabSuccessBlock)successBlock
                        failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSingleUserEndpoint, userId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLUser class]
                                                                                 successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];

    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:kUserEndpoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationPostMethod;
    request.HTTPBody = [self urlEncodeParams:[user jsonCreateRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLUser class]
                                                                                 successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)updateUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:kUserEndpoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationPutMethod;
    request.HTTPBody = [self urlEncodeParams:[user jsonRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLUser class]
                                                                                 successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)deleteUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSingleUserEndpoint, user.userId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationDeleteMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        successBlock(nil);
    };
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeVoid
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end
