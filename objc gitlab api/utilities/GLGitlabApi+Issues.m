//
//  GLGitlabApi+Issues.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Issues.h"
#import "GLGitlabApi+Private.h"
#import "GLIssue.h"

// Endpoints
static NSString * const kAllIssuesEndpoint = @"/issues";
static NSString * const kProjectIssuesEndpoint = @"/projects/%llu/issues";
static NSString * const kSingleIssueEndpoint = @"/projects/%llu/issues/%llu";

@implementation GLGitlabApi (Issues)
#pragma mark - Issues Methods

- (GLNetworkOperation *)getAllIssuesWithSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:kAllIssuesEndpoint
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self multipleObjectSuccessBlockForClass:[GLIssue class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getAllIssuesForProjectId:(int64_t)projectId
                                withSuccessBlock:(GLGitlabSuccessBlock)success
                                 andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kProjectIssuesEndpoint, projectId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self multipleObjectSuccessBlockForClass:[GLIssue class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getIssueWithId:(int64_t)issueId
                          forProjectId:(int64_t)projectId
                      withSuccessBlock:(GLGitlabSuccessBlock)success
                       andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleIssueEndpoint, projectId, issueId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLIssue class]
                                                                                 successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createIssue:(GLIssue *)issue
                   withSuccessBlock:(GLGitlabSuccessBlock)success
                    andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kProjectIssuesEndpoint, issue.projectId]
                                                     method:GLNetworkOperationPostMethod];
    request.HTTPBody = [self urlEncodeParams:[issue jsonCreateRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLIssue class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)updateIssue:(GLIssue *)issue
                   withSuccessBlock:(GLGitlabSuccessBlock)success
                    andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleIssueEndpoint, issue.projectId, issue.issueId]
                                                     method:GLNetworkOperationPutMethod];
    request.HTTPBody = [self urlEncodeParams:[issue jsonRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLIssue class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)closeIssue:(GLIssue *)issue
                  withSuccessBlock:(GLGitlabSuccessBlock)success
                   andFailureBlock:(GLGitlabFailureBlock)failure
{
    issue.state = @"closed";
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleIssueEndpoint, issue.projectId, issue.issueId]
                                                     method:GLNetworkOperationPutMethod];
    request.HTTPBody = [self urlEncodeParams:[issue jsonRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLIssue class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)reopenIssue:(GLIssue *)issue
                   withSuccessBlock:(GLGitlabSuccessBlock)success
                    andFailureBlock:(GLGitlabFailureBlock)failure
{
    issue.state = @"open";
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleIssueEndpoint, issue.projectId, issue.issueId]
                                                     method:GLNetworkOperationPutMethod];
    request.HTTPBody = [self urlEncodeParams:[issue jsonRepresentation]];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLIssue class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}


@end
