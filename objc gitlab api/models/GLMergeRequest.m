//
//  GLMergeRequest.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLMergeRequest.h"
#import "GLUser.h"
#import "GLGitlabApi.h"

static NSString * const kKeyId = @"id";
static NSString * const kKeyMergeRequestId = @"merge_request_id";
static NSString * const kKeyMergeRequestIid = @"iid";
static NSString * const kKeyTitle = @"title";
static NSString * const kKeyState = @"state";
static NSString * const kKeyAuthor = @"author";
static NSString * const kKeyAssignee = @"assignee";
static NSString * const kKeyTargetBranch = @"target_branch";
static NSString * const kKeySourceBranch = @"source_branch";
static NSString * const kKeyProjectId = @"project_id";
static NSString * const kKeyUpvotes = @"upvotes";
static NSString * const kKeyDownvotes = @"downvotes";

@implementation GLMergeRequest

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _mergeRequestId = [json[kKeyId] longLongValue];
        _mergeRequestIid = [json[kKeyMergeRequestIid] longLongValue];
        _title = [self checkForNull:json[kKeyTitle]];
        _state = [self checkForNull:json[kKeyState]];
        _author = [[GLUser alloc] initWithJSON:json[kKeyAuthor]];
        if ([self checkForNull:json[kKeyAssignee]]) {
            _assignee = [[GLUser alloc] initWithJSON:json[kKeyAssignee]];
        }
        _targetBranch = [self checkForNull:json[kKeyTargetBranch]];
        _sourceBranch = [self checkForNull:json[kKeySourceBranch]];
        _projectId = [json[kKeyProjectId] longLongValue];
        _upvotes = [json[kKeyUpvotes] intValue];
        _downvotes = [json[kKeyDownvotes] intValue];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToRequest:other];
}

- (BOOL)isEqualToRequest:(GLMergeRequest *)request {
    if (self == request)
        return YES;
    if (request == nil)
        return NO;
    if (self.mergeRequestId != request.mergeRequestId)
        return NO;
    if (self.mergeRequestIid != request.mergeRequestIid)
        return NO;
    if (self.title != request.title && ![self.title isEqualToString:request.title])
        return NO;
    if (self.state != request.state && ![self.state isEqualToString:request.state])
        return NO;
    if (self.author != request.author && ![self.author isEqualToUser:request.author])
        return NO;
    if (self.assignee != request.assignee && ![self.assignee isEqualToUser:request.assignee])
        return NO;
    if (self.targetBranch != request.targetBranch && ![self.targetBranch isEqualToString:request.targetBranch])
        return NO;
    if (self.sourceBranch != request.sourceBranch && ![self.sourceBranch isEqualToString:request.sourceBranch])
        return NO;
    if (self.projectId != request.projectId)
        return NO;
    if (self.upvotes != request.upvotes)
        return NO;
    if (self.downvotes != request.downvotes)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.mergeRequestId;
    hash = hash * 31u + (NSUInteger) self.mergeRequestIid;
    hash = hash * 31u + [self.title hash];
    hash = hash * 31u + [self.state hash];
    hash = hash * 31u + [self.author hash];
    hash = hash * 31u + [self.assignee hash];
    hash = hash * 31u + [self.targetBranch hash];
    hash = hash * 31u + [self.sourceBranch hash];
    hash = hash * 31u + (NSUInteger) self.projectId;
    hash = hash * 31u + self.upvotes;
    hash = hash * 31u + self.downvotes;
    return hash;
}


- (NSDictionary *)jsonRepresentation
{
    id null = (id)[NSNull null];
    return @{
             kKeyMergeRequestId: @(_mergeRequestId),
             kKeyMergeRequestIid: @(_mergeRequestIid),
             kKeyTitle: _title,
             kKeyState: _state ?: null,
             kKeyAuthor: @(_author.userId),
             kKeyAssignee: @(_assignee.userId),
             kKeyTargetBranch: _targetBranch ?: null,
             kKeySourceBranch: _sourceBranch ?: null,
             kKeyId: @(_projectId),
             kKeyUpvotes: @(_upvotes),
             kKeyDownvotes: @(_downvotes)
             };
}

- (NSDictionary *)jsonCreateRepresentation
{
    id null = (id)[NSNull null];
    return @{
             kKeyTitle: _title,
             kKeyAssignee: [_assignee jsonRepresentation] ?: null,
             kKeyTargetBranch: _targetBranch ?: null,
             kKeySourceBranch: _sourceBranch ?: null,
             kKeyId: @(_projectId)
             };
}

@end
