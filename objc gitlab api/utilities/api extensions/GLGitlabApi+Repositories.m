//
//  GLGitlabApi+Repositories.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Repositories.h"
#import "GLGitlabApi+Private.h"
#import "GLProject.h"
#import "GLBranch.h"
#import "GLTag.h"

@implementation GLGitlabApi (Repositories)
#pragma mark - Repository Methods
- (GLNetworkOperation *)getRepoBranchesForProject:(GLProject *)project
                                          success:(GLGitlabSuccessBlock)successBlock
                                          failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *branches = [self processJsonArray:responseObject class:[GLBranch class]];
        successBlock(branches);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getBranchNamed:(NSString *)branchName
                             inProject:(GLProject *)project
                               success:(GLGitlabSuccessBlock)successBlock
                               failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLBranch class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)protectBranch:(GLBranch *)branch
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLBranch class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)unprotectBranch:(GLBranch *)branch
                                success:(GLGitlabSuccessBlock)successBlock
                                failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLBranch class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getTagsForProject:(GLProject *)project
                                  success:(GLGitlabSuccessBlock)successBlock
                                  failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request;
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *tags = [self processJsonArray:responseObject class:[GLTag class]];
        successBlock(tags);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end
