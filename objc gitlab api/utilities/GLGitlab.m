//
//  GLGitlab.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlab.h"
#import "GLNetworkOperation.h"

@interface GLGitlab ()

@property (nonatomic, strong) NSURL *hostName;
@property (nonatomic, strong) NSString *privateToken;

@end

@implementation GLGitlab

static GLGitlab *_instance;

+ (GLGitlab *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GLGitlab alloc] init];
    });
    
    return _instance;
}

- (void)loginToHost:(NSString *)host username:(NSString *)username password:(NSString *)password success:(GLGitlabSuccessBlock)successBlock failure:(GLGitlabFailureBlock)failureBlock
{

}

@end
