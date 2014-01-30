//
//  GLMilestone.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/16/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLMilestone.h"
#import "GLGitlabApi.h"

static NSString * const kKeyMilestoneId = @"id";
static NSString * const kKeyMilestoneIid = @"iid";
static NSString * const kKeyProjectId = @"project_id";
static NSString * const kKeyTitle = @"title";
static NSString * const kKeyDescription = @"description";
static NSString * const kKeyDueDate = @"due_date";
static NSString * const kKeyState = @"state";
static NSString * const kKeyUpdatedAt = @"updated_at";
static NSString * const kKeyCreatedAt = @"created_at";

@implementation GLMilestone


- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _milestoneId = [json[kKeyMilestoneId] longLongValue];
        _milestoneIid = [json[kKeyMilestoneIid] longLongValue];
        _projectId = [json[kKeyProjectId] longLongValue];
        _title = [self checkForNull:json[kKeyTitle]];
        _milestoneDescription = [self checkForNull:json[kKeyDescription]];
        _state = [self checkForNull:json[kKeyState]];
        NSString *dueDateString = [self checkForNull:json[kKeyDueDate]];
        if (dueDateString) {
            _dueDate = [[[GLGitlabApi sharedInstance] dueDateFormatter] dateFromString:dueDateString];
        }
        
        _updatedAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyUpdatedAt]];
        _createdAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyCreatedAt]];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToMilestone:other];
}

- (BOOL)isEqualToMilestone:(GLMilestone *)milestone {
    if (self == milestone)
        return YES;
    if (milestone == nil)
        return NO;
    if (self.milestoneId != milestone.milestoneId)
        return NO;
    if (self.milestoneIid != milestone.milestoneIid)
        return NO;
    if (self.projectId != milestone.projectId)
        return NO;
    if (self.title != milestone.title && ![self.title isEqualToString:milestone.title])
        return NO;
    if (self.milestoneDescription != milestone.milestoneDescription && ![self.milestoneDescription isEqualToString:milestone.milestoneDescription])
        return NO;
    if (self.dueDate != milestone.dueDate && ![self.dueDate isEqualToDate:milestone.dueDate])
        return NO;
    if (self.state != milestone.state && ![self.state isEqualToString:milestone.state])
        return NO;
    if (self.updatedAt != milestone.updatedAt && ![self.updatedAt isEqualToDate:milestone.updatedAt])
        return NO;
    if (self.createdAt != milestone.createdAt && ![self.createdAt isEqualToDate:milestone.createdAt])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.milestoneId;
    hash = hash * 31u + (NSUInteger) self.milestoneIid;
    hash = hash * 31u + (NSUInteger) self.projectId;
    hash = hash * 31u + [self.title hash];
    hash = hash * 31u + [self.milestoneDescription hash];
    hash = hash * 31u + [self.dueDate hash];
    hash = hash * 31u + [self.state hash];
    hash = hash * 31u + [self.updatedAt hash];
    hash = hash * 31u + [self.createdAt hash];
    return hash;
}

- (NSDictionary *)jsonRepresentation
{
    id null = (id)[NSNull null];
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    return @{
             kKeyMilestoneId: @(_milestoneId),
             kKeyMilestoneIid: @(_milestoneIid),
             kKeyProjectId: @(_projectId),
             kKeyTitle: _title,
             kKeyDescription: _milestoneDescription ?: null,
             kKeyDueDate: _dueDate ? [formatter stringFromDate:_dueDate] : null,
             kKeyState: _state ?: null,
             kKeyUpdatedAt: _updatedAt ? [formatter stringFromDate:_updatedAt] : null,
             kKeyCreatedAt: _createdAt ? [formatter stringFromDate:_createdAt] : null
             };
}

- (NSDictionary *)jsonCreateRepresentation
{
    id null = (id)[NSNull null];
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    return @{
             kKeyProjectId: @(_projectId),
             kKeyTitle: _title,
             kKeyDescription: _milestoneDescription ?: null,
             kKeyDueDate: _dueDate ? [formatter stringFromDate:_createdAt] : null
             };
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.milestoneId=%qi", self.milestoneId];
    [description appendFormat:@", self.milestoneIid=%qi", self.milestoneIid];
    [description appendFormat:@", self.projectId=%qi", self.projectId];
    [description appendFormat:@", self.title=%@", self.title];
    [description appendFormat:@", self.description=%@", self.milestoneDescription];
    [description appendFormat:@", self.dueDate=%@", self.dueDate];
    [description appendFormat:@", self.state=%@", self.state];
    [description appendFormat:@", self.updatedAt=%@", self.updatedAt];
    [description appendFormat:@", self.createdAt=%@", self.createdAt];
    [description appendString:@">"];
    return description;
}

@end