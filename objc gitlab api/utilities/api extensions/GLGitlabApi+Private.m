//
//  GLGitlabApi+Private.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Private.h"
#import "GLConstants.h"
#import "GLJsonInit.h"

#pragma mark - Request Methods
NSString *const kPostMethod = @"post";
NSString *const kGetMethod = @"get";
NSString *const kPutMethod = @"put";

#pragma mark - End Points

#pragma mark -- User
NSString * const GLUserEndpoint = @"/users";

#pragma mark -- Commit
NSString * const GLCommitEndPoint = @"/commits";

#pragma mark -- Merge Request
NSString * const GLMergeRequestEndPoint = @"/merge_requests";

#pragma mark -- Project
NSString * const GLProjectEndpoint = @"/projects";
NSString * const GLProjectOwnedProjectsEndPoint = @"/projects/owned";
NSString * const GLProjectAllProjectsEndPoint = @"/projects/all";
NSString * const GLProjectGetProjectEndPoint = @"/projects/%d";


static NSString *const kApiRoutePrefix = @"/api/v3";

@implementation GLGitlabApi (Private)

@dynamic privateToken, hostName, queue;

- (GLNetworkOperation *)queueOperationWithRequest:(NSMutableURLRequest *)request
                                          success:(GLNetworkOperationSuccessBlock)success
                                          failure:(GLNetworkOperationFailureBlock)failure
{
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:success
                                                                 failure:failure];
    [self.queue addOperation:op];
    
    return op;
}

- (NSData *)urlEncodeParams:(NSDictionary *)params
{
    NSMutableArray *paramArray = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        [paramArray addObject:[NSString stringWithFormat:@"%@=%@", key, [self percentEncodeString:obj]]];
    }];
    NSString *paramString = [paramArray componentsJoinedByString:@"&"];
    
    return [paramString dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)percentEncodeString:(NSString *)unencodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                    (CFStringRef)unencodedString,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    return encodedString;
}

- (NSArray *)processJsonArray:(NSArray *)jsonArray class:(Class<GLJsonInit>)class
{
    Class aClass = (Class)class; // Cast back to a class to gain access to alloc
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dictionary in jsonArray) {
        id object = [[aClass alloc] initWithJSON:dictionary];
        [array addObject:object];
    }
    
    return [array copy];
}

- (NSURL *)requestUrlForEndPoint:(NSString *)endpoint
{
    NSURL *url = [self.hostName URLByAppendingPathComponent:kApiRoutePrefix];
    url = [url URLByAppendingPathComponent:endpoint];
    return url;
}

- (GLNetworkOperationFailureBlock)defaultFailureBlock:(GLGitlabFailureBlock)failureCallback
{
    return ^(NSError *error, NSInteger responseCode, NSData *responseData) {
        GLResponseCodes glResponseCode = responseCode;
        NSError *glError, *jsonError;
        NSString *domain;
        NSDictionary *userInfo;
        
        switch (glResponseCode) {
            case GLResponseSuccess:
                // Invalid for failure
                break;
            case GLResponseCreated:
                // Invalid for failure
                break;

            case GLResponseBadRequest:
                domain = GLGitlabApiBadRequestError;
                userInfo = [NSJSONSerialization JSONObjectWithData:responseData
                                                           options:0
                                                             error:&jsonError];
                break;

            case GLResponseUnauthorized:
                domain = GLGitlabApiUnauthorizedError;
                break;
                
            case GLResponseForbidden:
                domain = GLGitlabApiForbiddenError;
                break;

            case GLResponseNotFound:
                domain = GLGitlabApiNotFound;
                break;
                
            case GLResponseMethodNotAllowed:
                domain = GLGitLabApiMethodNotAllowedError;
                break;

            case GLResponseConflict:
                domain = GLGitlabApiConflictError;
                break;

            case GLResponseServerError:
                domain = GLGitlabApiServerError;
                break;

            case GLResponseTimeout:
                domain = GLGitLabApiTimeoutError;
                break;
        }
        
        if (jsonError) {
            NSLog(@"Error parsing json for network request failure: %@\nAdditional Information: %@", jsonError.localizedDescription, jsonError.userInfo);
        }
        
        if (domain) {
            glError = [[NSError alloc] initWithDomain:domain
                                                 code:glResponseCode
                                             userInfo:userInfo];
        }
        
        failureCallback(glError);
    };
}

- (GLNetworkOperationSuccessBlock)singleObjectSuccessBlockForClass:(Class <GLJsonInit>)class
                                                      successBlock:(GLGitlabSuccessBlock)success
{
    return ^(NSDictionary *resonseObject) {
        Class aClass = (Class)class; // Cast back to a class to gain access to alloc
        id object = [[aClass alloc] initWithJSON:resonseObject];
        success(object);
    };
}

@end

