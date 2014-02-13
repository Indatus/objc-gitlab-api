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
#import "GLGitlabApi.h"

static NSString * const kKeyId = @"id";
static NSString * const kKeyIssueId = @"issue_id";
static NSString * const kKeyIssueIid = @"iid";
static NSString * const kKeyProjectId = @"project_id";
static NSString * const kKeyTitle = @"title";
static NSString * const kKeyDescription = @"description";
static NSString * const kKeyLabels = @"labels";
static NSString * const kKeyMilestone = @"milestone";
static NSString * const kKeyAssignee = @"assignee";
static NSString * const kKeyAuthor = @"author";
static NSString * const kKeyState = @"state";
static NSString * const kKeyUpdatedAt = @"updated_at";
static NSString * const kKeyCreatedAt = @"created_at";

@implementation GLIssue

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _issueId = [json[kKeyId] longLongValue];
        _issueIid = [json[kKeyIssueIid] longLongValue];
        _projectId = [json[kKeyProjectId] longLongValue];
        _title = [self checkForNull:json[kKeyTitle]];
        _issueDescription = [self checkForNull:json[kKeyDescription]];
        _labels = [self checkForNull:json[kKeyLabels]];
        _milestone = [self checkForNull:json[kKeyMilestone]] ? [[GLMilestone alloc] initWithJSON:json[kKeyMilestone]] : nil;
        _assignee = [self checkForNull:json[kKeyAssignee]] ? [[GLUser alloc] initWithJSON:json[kKeyAssignee]] : nil;
        _author = [self checkForNull:json[kKeyAuthor]] ? [[GLUser alloc] initWithJSON:json[kKeyAuthor]] : nil;
        _state = [self checkForNull:json[kKeyState]];
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
    
    return [self isEqualToIssue:other];
}

- (BOOL)isEqualToIssue:(GLIssue *)issue {
    if (self == issue)
        return YES;
    if (issue == nil)
        return NO;
    if (self.issueId != issue.issueId)
        return NO;
    if (self.issueIid != issue.issueIid)
        return NO;
    if (self.projectId != issue.projectId)
        return NO;
    if (self.title != issue.title && ![self.title isEqualToString:issue.title])
        return NO;
    if (self.issueDescription != issue.issueDescription && ![self.issueDescription isEqualToString:issue.issueDescription])
        return NO;
    if (self.labels != issue.labels && ![self.labels isEqualToArray:issue.labels])
        return NO;
    if (self.milestone != issue.milestone && ![self.milestone isEqualToMilestone:issue.milestone])
        return NO;
    if (self.assignee != issue.assignee && ![self.assignee isEqualToUser:issue.assignee])
        return NO;
    if (self.author != issue.author && ![self.author isEqualToUser:issue.author])
        return NO;
    if (self.state != issue.state && ![self.state isEqualToString:issue.state])
        return NO;
    if (self.updatedAt != issue.updatedAt && ![self.updatedAt isEqualToDate:issue.updatedAt])
        return NO;
    if (self.createdAt != issue.createdAt && ![self.createdAt isEqualToDate:issue.createdAt])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.issueId;
    hash = hash * 31u + (NSUInteger) self.issueIid;
    hash = hash * 31u + (NSUInteger) self.projectId;
    hash = hash * 31u + [self.title hash];
    hash = hash * 31u + [self.issueDescription hash];
    hash = hash * 31u + [self.labels hash];
    hash = hash * 31u + [self.milestone hash];
    hash = hash * 31u + [self.assignee hash];
    hash = hash * 31u + [self.author hash];
    hash = hash * 31u + [self.state hash];
    hash = hash * 31u + [self.updatedAt hash];
    hash = hash * 31u + [self.createdAt hash];
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.issueId=%qi", self.issueId];
    [description appendFormat:@", self.issueIid=%qi", self.issueIid];
    [description appendFormat:@", self.projectId=%qi", self.projectId];
    [description appendFormat:@", self.title=%@", self.title];
    [description appendFormat:@", self.description=%@", self.issueDescription];
    [description appendFormat:@", self.labels=%@", self.labels];
    [description appendFormat:@", self.milestone=%@", self.milestone];
    [description appendFormat:@", self.assignee=%@", self.assignee];
    [description appendFormat:@", self.author=%@", self.author];
    [description appendFormat:@", self.state=%@", self.state];
    [description appendFormat:@", self.updatedAt=%@", self.updatedAt];
    [description appendFormat:@", self.createdAt=%@", self.createdAt];
    [description appendString:@">"];
    return description;
}

- (NSDictionary *)jsonRepresentation
{
    id null = (id)[NSNull null];
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    return @{
             kKeyIssueId: @(_issueId),
             kKeyIssueIid: @(_issueIid),
             kKeyProjectId: @(_projectId),
             kKeyTitle: _title ?: null,
             kKeyDescription: _issueDescription ?: null,
             kKeyLabels: _labels ?: null,
             kKeyMilestone: @(_milestone.milestoneId) ?: null,
             kKeyAssignee: @(_assignee.userId) ?: null,
             kKeyAuthor: [_author jsonRepresentation] ?: null,
             kKeyState: _state ?: null,
             kKeyUpdatedAt: _updatedAt ? [formatter stringFromDate:_updatedAt] : null,
             kKeyCreatedAt: _createdAt ? [formatter stringFromDate:_createdAt] : null
             };
}

- (NSDictionary *)jsonCreateRepresentation
{
    id null = (id)[NSNull null];
    return @{
             kKeyId: @(_projectId),
             kKeyTitle: _title,
             kKeyDescription: _issueDescription ?: null,
             kKeyLabels: _labels ?: null,
             kKeyMilestone: @(_milestone.milestoneId) ?: null,
             kKeyAssignee: @(_assignee.userId) ?: null
             };
}


@end
