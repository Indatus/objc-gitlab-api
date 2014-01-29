//
//  GLEvent.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/28/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLEvent.h"

static NSString * const kKeyTitle = @"title";
static NSString * const kKeyProjectId = @"project_id";
static NSString * const kKeyActionName = @"action_name";
static NSString * const kKeyTargetId = @"target_id";
static NSString * const kKeyTargetType = @"target_type";
static NSString * const kKeyAuthorId = @"author_id";
static NSString * const kKeyData = @"data";
static NSString * const kKeyRepository = @"repository";
static NSString * const kKeyCommits = @"commits";
static NSString * const kKeyTargetTitle = @"target_title";

@implementation GLEvent

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _title = [self checkForNull:json[kKeyTitle]];
        _projectId = [[self checkForNull:json[kKeyProjectId]] longLongValue];
        _actionName = [self checkForNull:json[kKeyActionName]];
        _targetId = [[self checkForNull:json[kKeyTargetId]] longLongValue];
        _targetType = [self checkForNull:json[kKeyTargetType]];
        _authorId = [[self checkForNull:json[kKeyAuthorId]] longLongValue];
        _data = json[kKeyData];
        if ((id)_data == [NSNull null]) {
            _data = nil;
        }
        _targetTitle = [self checkForNull:json[kKeyTargetTitle]];
    }
    
    return self;
}

- (BOOL)isEqual:(id)other
{
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToEvent:other];
}

- (BOOL)isEqualToEvent:(GLEvent *)event
{
    if (self == event)
        return YES;
    if (event == nil)
        return NO;
    if (self.title != event.title && ![self.title isEqualToString:event.title])
        return NO;
    if (self.projectId != event.projectId)
        return NO;
    if (self.actionName != event.actionName && ![self.actionName isEqualToString:event.actionName])
        return NO;
    if (self.targetId != event.targetId)
        return NO;
    if (self.targetType != event.targetType && ![self.targetType isEqualToString:event.targetType])
        return NO;
    if (self.authorId != event.authorId)
        return NO;
    if (self.data != event.data && ![self.data isEqualToDictionary:event.data])
        return NO;
    if (self.targetTitle != event.targetTitle && ![self.targetTitle isEqualToString:event.targetTitle])
        return NO;
    return YES;
}

- (NSUInteger)hash
{
    NSUInteger hash = [self.title hash];
    hash = hash * 31u + (NSUInteger) self.projectId;
    hash = hash * 31u + [self.actionName hash];
    hash = hash * 31u + (NSUInteger) self.targetId;
    hash = hash * 31u + [self.targetType hash];
    hash = hash * 31u + (NSUInteger) self.authorId;
    hash = hash * 31u + [self.data hash];
    hash = hash * 31u + [self.targetTitle hash];
    return hash;
}

- (NSString *)description
{
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.title=%@", self.title];
    [description appendFormat:@", self.projectId=%qi", self.projectId];
    [description appendFormat:@", self.actionName=%@", self.actionName];
    [description appendFormat:@", self.targetId=%qi", self.targetId];
    [description appendFormat:@", self.targetType=%@", self.targetType];
    [description appendFormat:@", self.authorId=%qi", self.authorId];
    [description appendFormat:@", self.data=%@", self.data];
    [description appendFormat:@", self.targetTitle=%@", self.targetTitle];
    [description appendString:@">"];
    return description;
}


- (NSDictionary *)jsonRepresentation
{
    id null = (id)[NSNull null];
    return @{
             kKeyTitle: _title ?: null,
             kKeyActionName: _actionName ?: null,
             kKeyTargetId: @(_targetId),
             kKeyTargetType: _targetType ?: null,
             kKeyAuthorId: @(_authorId),
             kKeyData: _data ?: null,
             kKeyTargetTitle: _targetTitle ?: null
             };
}

@end
