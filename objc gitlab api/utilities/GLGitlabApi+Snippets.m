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
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSnippetsEndPoint, projectId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self multipleObjectSuccessBlockForClass:[GLSnippet class] successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getSnippet:(int64_t)snippetId
                      forProjectId:(int64_t)projectId
                           success:(GLGitlabSuccessBlock)successBlock
                           failure:(GLGitlabFailureBlock)failureBlock;
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleSnippetEndPoint, projectId, snippetId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLSnippet class] successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createSnippet:(GLSnippet *)snippet
                         forProjectId:(int64_t)projectId
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSnippetsEndPoint, projectId]
                                                     method:GLNetworkOperationPostMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLSnippet class] successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)updateSnippet:(GLSnippet *)snippet
                         forProjectId:(int64_t)projectId
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleSnippetEndPoint, projectId, snippet.snippetId]
                                                     method:GLNetworkOperationPutMethod];

    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLSnippet class] successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)deleteSnippet:(GLSnippet *)snippet
                         forProjectId:(int64_t)projectId
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleSnippetEndPoint, projectId, snippet.snippetId]
                                                     method:GLNetworkOperationDeleteMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLSnippet class] successBlock:successBlock];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getRawSnippet:(GLSnippet *)snippet
                         forProjectId:(int64_t)projectId
                              success:(GLGitlabSuccessBlock)successBlock
                              failure:(GLGitlabFailureBlock)failureBlock
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleSnippetRawEndPoint, projectId, snippet.snippetId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSData *responseData) {
        NSString *string = [[NSString alloc] initWithData:responseData
                                                 encoding:NSUTF8StringEncoding];
        successBlock(string);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failureBlock];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeRaw
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

@end
