//
//  GLGitlabApi+Snippets.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Snippets.h"
#import "GLGitlabApi+Private.h"
#import "GLSnippet.h"

// Endpoints
static NSString * const kSnippetsEndPoint = @"/projects/%llu/snippets";
static NSString * const kSingleSnippetEndPoint = @"/projects/%llu/snippets/%llu";
static NSString * const kSingleSnippetRawEndPoint = @"/projects/%llu/snippets/%llu/raw";

@implementation GLGitlabApi (Snippets)
#pragma mark - Snippet Methods
- (GLNetworkOperation *)getSnippetsForProjectId:(int64_t)projectId
                                        success:(GLGitlabSuccessBlock)successBlock
                                        failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSnippetsEndPoint, projectId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *snippets = [self processJsonArray:responseObject class:[GLSnippet class]];
        successBlock(snippets);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getSnippet:(int64_t)snippetId
                      forProjectId:(int64_t)projectId
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock;
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSingleSnippetEndPoint, projectId, snippetId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLSnippet class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createSnippet:(GLSnippet *)snippet
                         forProjectId:(int64_t)projectId
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSnippetsEndPoint, projectId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationPostMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLSnippet class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)updateSnippet:(GLSnippet *)snippet
                         forProjectId:(int64_t)projectId
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSingleSnippetEndPoint, projectId, snippet.snippetId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationPutMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLSnippet class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)deleteSnippet:(GLSnippet *)snippet
                         forProjectId:(int64_t)projectId
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSingleSnippetEndPoint, projectId, snippet.snippetId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationDeleteMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLSnippet class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getRawSnippet:(GLSnippet *)snippet
                         forProjectId:(int64_t)projectId
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kSingleSnippetRawEndPoint, projectId, snippet.snippetId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[NSString class] successBlock:successBlock];
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end
