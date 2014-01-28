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

// Endpoints
static NSString * const kBranchesEndPoint = @"/projects/%llu/repository/branches";
static NSString * const kSingleBranchEndPoint = @"/projects/%llu/repository/branches/%@";
static NSString * const kSingleBranchProtectEndPoint = @"/projects/%llu/repository/branches/%@/protect";
static NSString * const kSingleBranchUnprotectEndPoint = @"/projects/%llu/repository/branches/%@/unprotect";
static NSString * const kTagsEndPoint = @"/projects/%llu/repository/tags";

@implementation GLGitlabApi (Repositories)
#pragma mark - Repository Methods
- (GLNetworkOperation *)getRepoBranchesForProject:(GLProject *)project
                                          success:(GLGitlabSuccessBlock)successBlock
                                          failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kBranchesEndPoint, project.projectId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
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
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSingleBranchEndPoint, project.projectId, branchName]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLBranch class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)protectBranch:(GLBranch *)branch
                            inProject:(GLProject *)project
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSingleBranchProtectEndPoint, project.projectId, branch.name]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationPutMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLBranch class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)unprotectBranch:(GLBranch *)branch
                              inProject:(GLProject *)project
                                success:(GLGitlabSuccessBlock)successBlock
                                failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSingleBranchUnprotectEndPoint, project.projectId, branch.name]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationPutMethod;
    
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
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kTagsEndPoint, project.projectId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
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
