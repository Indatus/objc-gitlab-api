//
//  GLGitlabApi+Files.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Files.h"
#import "GLGitlabApi+Private.h"
#import "GLFile.h"

// Endpoint
static NSString * const kTreeEndpoint = @"/projects/%llu/repository/tree";
static NSString * const kBlobEndpoint = @"/projects/%llu/repository/raw_blobs/%@";

// Param keys
static NSString * const kPath = @"path";
static NSString * const kRefName = @"ref_name";

@implementation GLGitlabApi (Files)

- (GLNetworkOperation *)getRepositoryTreeForProjectId:(int64_t)projectId
                                                 path:(NSString *)path
                                           branchName:(NSString *)branch
                                     withSuccessBlock:(GLGitlabSuccessBlock)success
                                      andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kTreeEndpoint, projectId]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    if (path || branch) {
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        if (path) {
            params[kPath] = path;
        }
        
        if (branch) {
            params[kRefName] = branch;
        }
        
        request.HTTPBody = [self urlEncodeParams:params];
    }
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *files = [self processJsonArray:responseObject class:[GLFile class]];
        success(files);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeRaw
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getFileContentFromProject:(int64_t)projectId
                                              sha:(NSString *)sha
                                 withSuccessBlock:(GLGitlabSuccessBlock)success
                                  andFailureBlock:(GLGitlabFailureBlock)failure;
{
    NSURL *url = [self requestUrlForEndPoint:[NSString stringWithFormat:kBlobEndpoint, projectId, sha]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSData *responseData) {
        success(responseData);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeRaw
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
    }

@end
