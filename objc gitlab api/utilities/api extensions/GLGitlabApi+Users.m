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

// Parameter Keys
static NSString * const kPageParam = @"page";
static NSString * const kPerPageParam = @"per_page";

@implementation GLGitlabApi (Users)
#pragma mark - User Methods

- (GLNetworkOperation *)getUsers:(ino64_t)pageNumber
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
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getUser:(ino64_t)userId
                        success:(GLGitlabSuccessBlock)successBlock
                        failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLUser class]
                                                                                 successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLUser class]
                                                                                 successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)updateUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLUser class]
                                                                                 successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)deleteUser:(GLUser *)user
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        successBlock(nil);
    };
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end
