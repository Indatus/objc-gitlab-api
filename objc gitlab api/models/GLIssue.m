//
//  GLIssue.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/16/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLIssue.h"
#import "GLMilestone.h"
#import "GLUser.h"
#import "GLGitlab.h"

NSString * const kKeyIssueId = @"id";
NSString * const kKeyIssueIid = @"iid";
NSString * const kKeyProjectId = @"project_id";
NSString * const kKeyTitle = @"title";
NSString * const kKeyDescription = @"description";
NSString * const kKeyLabels = @"labels";
NSString * const kKeyMilestone = @"milestone";
NSString * const kKeyAssignee = @"assignee";
NSString * const kKeyAuthor = @"author";
NSString * const kKeyState = @"state";
NSString * const kKeyUpdatedAt = @"updated_at";
NSString * const kKeyCreatedAt = @"created_at";

@implementation GLIssue

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _issueId = [json[kKeyIssueId] longLongValue];
        _issueIid = [json[kKeyIssueIid] longLongValue];
        _projectId = [json[kKeyProjectId] longLongValue];
        _title = json[kKeyTitle];
        _description = json[kKeyDescription];
        _labels = [json[kKeyLabels] array];
        _milestone = [[GLMilestone alloc] initWithJSON:json[kKeyMilestone]];
        _assignee = [[GLUser alloc] initWithJSON:json[kKeyAssignee]];
        _author = [[GLUser alloc] initWithJSON:json[kKeyAuthor]];
        _state = json[kKeyState];
        _updatedAt = [[[GLGitlab sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyUpdatedAt]];
        _createdAt = [[[GLGitlab sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyCreatedAt]];
    }
    return self;
}

@end
