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
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation GLGitlab

static GLGitlab *_instance;

- (instancetype)init
{
    if ((self = [super init]))
    {
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

- (void)loginToHost:(NSString *)host username:(NSString *)username password:(NSString *)password success:(GLGitlabSuccessBlock)successBlock failure:(GLGitlabFailureBlock)failureBlock
{

}

@end
