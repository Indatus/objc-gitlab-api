//
//  GLGitlabApi+Private.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Private.h"
#import "GLJsonInit.h"

NSString *const kPostMethod = @"post";
NSString *const kGetMethod = @"get";
NSString *const kPutMethod = @"put";
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
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                                    NULL,
                                                                                                    (CFStringRef)unencodedString,
                                                                                                    NULL,
                                                                                                    (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                                    kCFStringEncodingUTF8 ));
    return encodedString;
}

- (NSArray *)processJsonArray:(NSArray *)jsonArray class:(Class)class
{
    if (![class conformsToProtocol:@protocol(GLJsonInit)]) {
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
@end
