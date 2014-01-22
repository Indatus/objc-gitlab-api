//
//  GLGitlabApi+Private.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"
#import "GLNetworkOperation.h"

#pragma mark - Request Methods
FOUNDATION_EXPORT NSString *const kPostMethod;
FOUNDATION_EXPORT NSString *const kGetMethod;
FOUNDATION_EXPORT NSString *const kPutMethod;

#pragma mark - End Points

#pragma mark -- Usser
FOUNDATION_EXPORT NSString *const GLUserEndpoint;

#pragma mark -- Commit
FOUNDATION_EXPORT NSString * const GLCommitEndPoint;

#pragma mark -- Merge Request
FOUNDATION_EXPORT NSString * const GLMergeRequestEndPoint;

#pragma mark -- Project
FOUNDATION_EXPORT NSString *const GLProjectEndpoint;
FOUNDATION_EXPORT NSString *const GLProjectOwnedProjectsEndPoint;
FOUNDATION_EXPORT NSString *const GLProjectAllProjectsEndPoint;
FOUNDATION_EXPORT NSString *const GLProjectGetProjectEndPoint;

@interface GLGitlabApi (Private)

@property (nonatomic, strong) NSURL *hostName;
@property (nonatomic, strong) NSString *privateToken;
@property (nonatomic, strong) NSOperationQueue  *queue;

- (GLNetworkOperation *)queueOperationWithRequest:(NSMutableURLRequest *)request
                                          success:(GLNetworkOperationSuccessBlock)success
                                          failure:(GLNetworkOperationFailureBlock)failure;
- (NSData *)urlEncodeParams:(NSDictionary *)params;
- (NSArray *)processJsonArray:(NSArray *)jsonArray class:(Class)class;
- (NSURL *)requestUrlForEndPoint:(NSString *)endpoint;
- (GLNetworkOperationFailureBlock)defaultFailureBlock:(GLGitlabFailureBlock)failureCallback;
@end
