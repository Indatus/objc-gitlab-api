//
//  GLGitlabApi+Session.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Session.h"
#import "GLGitlabApi+Private.h"
#import "GLUser.h"

static NSString * const kLoginRoute = @"/session";

// Request Keys
static NSString * const kLoginUsernameKey = @"login";
static NSString * const kLoginPasswordKey = @"password";

// Response Keys
static NSString *const kPrivateTokenKey = @"private_token";

@implementation GLGitlabApi (Session)


- (GLNetworkOperation *)loginToHost:(NSString *)host
                           username:(NSString *)username
                           password:(NSString *)password
                            success:(GLGitlabSuccessBlock)successBlock
                            failure:(GLGitlabFailureBlock)failureBlock
{
    self.hostName = [NSURL URLWithString:host];
    NSDictionary *params = @{ kLoginUsernameKey: username, kLoginPasswordKey: password };
    NSMutableURLRequest *request = [self requestForEndPoint:kLoginRoute
                                                     method:GLNetworkOperationPostMethod];
    NSError *error;
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
    
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}
@end
