//
//  GLGitlab.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlab.h"
#import "GLNetworkOperation.h"

#import "GLUser.h"

static NSString *const kPostMethod = @"post";
static NSString *const kApiRoutePrefix = @"/api/v3";
static NSString *const kLoginRoute = @"/session";

// Request Keys
static NSString *const kLoginUsernameKey = @"login";
static NSString *const kLoginPasswordKey = @"password";

// Response Keys
static NSString *const kPrivateTokenKey = @"private_token";

@interface GLGitlab ()

@property (nonatomic, strong) NSURL *hostName;
@property (nonatomic, strong) NSString *privateToken;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSOperationQueue  *queue;
@end

@implementation GLGitlab

static GLGitlab *_instance;

- (instancetype)init
{
    if ((self = [super init]))
    {
        _queue = [[NSOperationQueue alloc] init];
        _queue.name = @"GitLab Operations";
        [_queue setSuspended:NO];
        // GitLab Date String: 2012-05-23T08:00:58Z
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateFormat:@"yyyy-MM-d'T'hh:mm:ssZ"];
    }
    
    return self;
}

+ (GLGitlab *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GLGitlab alloc] init];
    });
    
    return _instance;
}

- (NSDateFormatter *)gitLabDateFormatter
{
    return _dateFormatter;
}

- (GLNetworkOperation *)loginToHost:(NSString *)host username:(NSString *)username password:(NSString *)password success:(GLGitlabSuccessBlock)successBlock failure:(GLGitlabFailureBlock)failureBlock
{
    self.hostName = [NSURL URLWithString:host];

    NSURL *requestUrl = [_hostName URLByAppendingPathComponent:kApiRoutePrefix];
    requestUrl = [requestUrl URLByAppendingPathComponent:kLoginRoute];
    NSDictionary *params = @{ kLoginUsernameKey: username, kLoginPasswordKey: password };
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    NSError *error;
    
    request.HTTPMethod = kPostMethod;
    request.HTTPBody = [self urlEncodeParams:params];
    if (error) {
        NSLog(@"Error serializing login params: %@", error.localizedDescription);
        failureBlock(error);
        return nil;
    }
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        self.privateToken = responseObject[kPrivateTokenKey];
        GLUser *user = [[GLUser alloc] initWithJSON:responseObject];
        successBlock(user);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        failureBlock(error);
    };
    
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

#pragma mark - Private Methods

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

@end
