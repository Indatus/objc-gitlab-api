//
//  GLMilestone.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/16/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLMilestone.h"
#import "GLGitlab.h"

NSString * const kKeyMilestoneId = @"id";
NSString * const kKeyMilestoneIid = @"iid";
NSString * const kKeyProjectId = @"project_id";
NSString * const kKeyTitle = @"title";
NSString * const kKeyDescription = @"description";
NSString * const kKeyDueDate = @"due_date";
NSString * const kKeyState = @"state";
NSString * const kKeyUpdatedAt = @"updated_at";
NSString * const kKeyCreatedAt = @"created_at";

@implementation GLMilestone

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _milestoneId = [json[kKeyMilestoneId] longLongValue];
        _milestoneIid = [json[kKeyMilestoneIid] longLongValue];
        _projectId = [json[kKeyProjectId] longLongValue];
        _title = json[kKeyTitle];
        _description = json[kKeyDescription];
        _dueDate = [[[GLGitlab sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyDueDate]];
        _state = json[kKeyState];
        _updatedAt = [[[GLGitlab sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyUpdatedAt]];
        _createdAt = [[[GLGitlab sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyCreatedAt]];
    }
    return self;
}

@end