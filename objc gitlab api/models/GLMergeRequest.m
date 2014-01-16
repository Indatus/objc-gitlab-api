//
//  GLMergeRequest.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLMergeRequest.h"
#import "GLUser.h"

NSString * const GLMergeRequestEndPoint = @"/merge_requests";

NSString * const kKeyMergeRequestId = @"id";
NSString * const kKeyMergeRequestIid = @"iid";
NSString * const kKeyTitle = @"title";
NSString * const kKeyState = @"state";
NSString * const kKeyAuthor = @"author";
NSString * const kKeyAssignee = @"assignee";
NSString * const kKeyTargetBranch = @"target_branch";
NSString * const kKeySourceBranch = @"source_branch";
NSString * const kKeyProjectId = @"project_id";
NSString * const kKeyUpvotes = @"upvotes";
NSString * const kKeyDownvotes = @"downvotes";

@implementation GLMergeRequest

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _mergeRequestId = [json[kKeyMergeRequestId] longLongValue];
        _mergeRequestIid = [json[kKeyMergeRequestIid] longLongValue];
        _title = json[kKeyTitle];
        _state = json[kKeyState];
        _author = [GLUser initWithJSON:json[kKeyAuthor]];
        _assignee = [GLUser initWithJSON:json[kKeyAssignee]];
        _targetBranch = json[kKeyTargetBranch];
        _sourceBranch = json[kKeySourceBranch];
        _projectId = [json[kKeyProjectId] longLongValue];
        _upvotes = [json[kKeyUpvotes] intValue];
        _downvotes = [json[kKeyDownvotes] intValue];
    }
    return self;
}

@end
