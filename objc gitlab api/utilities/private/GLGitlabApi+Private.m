//
//  GLGitlabApi+Private.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Private.h"
#import "GLConstants.h"
#import "GLBaseObject.h"
#import "NSURL+GLAdditions.h"

static NSString * const kApiRoutePrefix = @"/api/v3";
static NSString * const kPrivateTokenHeaderKey = @"PRIVATE-TOKEN";

@implementation GLGitlabApi (Private)

@dynamic privateToken, hostName, queue;

- (GLNetworkOperation *)queueOperationWithRequest:(NSMutableURLRequest *)request
                                             type:(GLNetworkOperationType)type
                                          success:(GLNetworkOperationSuccessBlock)success
                                          failure:(GLNetworkOperationFailureBlock)failure
{
    if (self.privateToken) {
        [request addValue:self.privateToken forHTTPHeaderField:kPrivateTokenHeaderKey];
    }
    
    if (![request.HTTPMethod isEqualToString:GLNetworkOperationGetMethod] && request.HTTPBody.length) {
        [request addValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    }
    
    GLNetworkOperation *op = [GLNetworkOperation operationOfType:type
                                                         request:request
                                                         success:success
                                                         failure:failure];

    [self.queue addOperation:op];
    
    return op;
}

- (NSString *)urlEncodeParamsForGet:(NSDictionary *)params
{
    NSMutableArray *paramArray = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            [paramArray addObject:[NSString stringWithFormat:@"%@=%@", key, [self percentEncodeString:obj]]];
        }
        else {
            [paramArray addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSString *paramString = [paramArray componentsJoinedByString:@"&"];
    return paramString;
}

- (NSString *)urlEncodeParamsForGet:(NSDictionary *)params endpoint:(NSString *)endpoint
{
    NSString *paramString = [self urlEncodeParamsForGet:params];
    return [endpoint stringByAppendingFormat:@"?%@", paramString];
}

- (NSData *)urlEncodeParams:(NSDictionary *)params
{
    NSString *paramString = [self urlEncodeParamsForGet:params];
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

- (NSArray *)processJsonArray:(NSArray *)jsonArray class:(Class)class
{
    if (![class isSubclassOfClass:[GLBaseObject class]] || !jsonArray) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dictionary in jsonArray) {
        id object = [[class alloc] initWithJSON:dictionary];
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

- (NSMutableURLRequest *)requestForEndPoint:(NSString *)endpoint method:(NSString *)method
{
    NSURL *url = [self requestUrlForEndPoint:endpoint];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    
    return request;
}

- (NSMutableURLRequest *)requestForEndPoint:(NSString *)endpoint params:(NSDictionary *)params method:(NSString *)method
{
    NSURL *url = [self requestUrlForEndPoint:endpoint];

    if (params && [method isEqualToString:GLNetworkOperationGetMethod]) {
        NSString *queryString = [self urlEncodeParamsForGet:params];
        url = [url URLByAppendingQueryString:queryString];
    }

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    
    if (params && ![method isEqualToString:GLNetworkOperationGetMethod]) {
        request.HTTPBody = [self urlEncodeParams:params];
    }
    
    return request;
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

- (GLNetworkOperationSuccessBlock)singleObjectSuccessBlockForClass:(Class)class
                                                      successBlock:(GLGitlabSuccessBlock)success
{
    if (![class isSubclassOfClass:[GLBaseObject class]]) {
        return nil;
    }
    
    return ^(NSDictionary *resonseObject) {
        id object = [[class alloc] initWithJSON:resonseObject];
        success(object);
    };
}

- (GLNetworkOperationSuccessBlock)multipleObjectSuccessBlockForClass:(Class)class
                                                        successBlock:(GLGitlabSuccessBlock)success
{
    if (![class isSubclassOfClass:[GLBaseObject class]]) {
        return nil;
    }
    
    return ^(NSArray *responseObject) {
        NSArray *objects = [self processJsonArray:responseObject class:class];
        success(objects);
    };
}

@end

