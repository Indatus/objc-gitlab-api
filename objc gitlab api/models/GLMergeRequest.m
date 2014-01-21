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
        _author = [[GLUser alloc] initWithJSON:json[kKeyAuthor]];
        _assignee = [[GLUser alloc] initWithJSON:json[kKeyAssignee]];
        _targetBranch = json[kKeyTargetBranch];
        _sourceBranch = json[kKeySourceBranch];
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

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.mergeRequestId=%qi", self.mergeRequestId];
    [description appendFormat:@", self.mergeRequestIid=%qi", self.mergeRequestIid];
    [description appendFormat:@", self.title=%@", self.title];
    [description appendFormat:@", self.state=%@", self.state];
    [description appendFormat:@", self.author=%@", self.author];
    [description appendFormat:@", self.assignee=%@", self.assignee];
    [description appendFormat:@", self.targetBranch=%@", self.targetBranch];
    [description appendFormat:@", self.sourceBranch=%@", self.sourceBranch];
    [description appendFormat:@", self.projectId=%qi", self.projectId];
    [description appendFormat:@", self.upvotes=%i", self.upvotes];
    [description appendFormat:@", self.downvotes=%i", self.downvotes];
    [description appendString:@">"];
    return description;
}

@end
