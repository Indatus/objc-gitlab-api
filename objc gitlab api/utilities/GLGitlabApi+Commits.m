//
//  GLGitlabApi+Commits.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Commits.h"
#import "GLGitlabApi+Private.h"
#import "GLCommit.h"
#import "GLDiff.h"

static NSString * const kCommitEndPoint = @"/projects/%llu/repository/commits";
static NSString * const kSingleCommitEndPoint = @"/projects/%llu/repository/commits/%@";
static NSString * const kSingleCommitDiffEndPoint = @"/projects/%llu/repository/commits/%@/diff";

@implementation GLGitlabApi (Commits)

- (GLNetworkOperation *)getAllCommitsForProjectId:(int64_t)projectId
                                 withSuccessBlock:(GLGitlabSuccessBlock)success
                                  andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kCommitEndPoint, projectId]
                                                     method:GLNetworkOperationGetMethod];
    GLNetworkOperationSuccessBlock localSuccessBlock = [self multipleObjectSuccessBlockForClass:[GLCommit class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}
- (GLNetworkOperation *)getCommitWithSha:(NSString *)sha
                            forProjectId:(int64_t)projectId
                        withSuccessBlock:(GLGitlabSuccessBlock)success
                         andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleCommitEndPoint, projectId, sha]
                                                     method:GLNetworkOperationGetMethod];
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLCommit class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getCommitDiffWithSha:(NSString *)sha
                                forProjectId:(int64_t)projectId
                            withSuccessBlock:(GLGitlabSuccessBlock)success
                             andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleCommitDiffEndPoint, projectId, sha]
                                                     method:GLNetworkOperationGetMethod];
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLDiff class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end
