//
//  GLGitlabApi.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"
#import "GLNetworkOperation.h"
#import "GLJsonProtocol.h"
#import "GLProject.h"
#import "GLUser.h"
#import "GLMergeRequest.h"
#import "GLProject.h"
#import "GLNote.h"
#import "GLDiff.h"
#import "GLSnippet.h"

@interface GLGitlabApi ()

@property (nonatomic, strong) NSURL *hostName;
@property (nonatomic, strong) NSString *privateToken;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSOperationQueue  *queue;
@end

@implementation GLGitlabApi

static GLGitlabApi *_instance;

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

+ (GLGitlabApi *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GLGitlabApi alloc] init];
    });
    
    return _instance;
}

- (NSDateFormatter *)gitLabDateFormatter
{
    return _dateFormatter;
}

@end
