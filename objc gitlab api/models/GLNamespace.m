//
//  GLNamespace.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLNamespace.h"
#import "GLGitlabApi.h"

static NSString * const kKeyNamespaceId = @"id";
static NSString * const kKeyName = @"name";
static NSString * const kKeyPath = @"path";
static NSString * const kKeyDescription = @"description";
static NSString * const kKeyCreatedAt = @"created_at";
static NSString * const kKeyUpdatedAt = @"updated_at";
static NSString * const kKeyOwnerId = @"owner_id";

@implementation GLNamespace

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _namespaceId = [json[kKeyNamespaceId] longLongValue];
        _name = [self checkForNull:json[kKeyName]];
        _path = [self checkForNull:json[kKeyPath]];
        _namespaceDescription = [self checkForNull:json[kKeyDescription]];
        _createdAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyCreatedAt]];
        _updatedAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyUpdatedAt]];
        _ownerId = [json[kKeyOwnerId] longLongValue];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToGlNamespace:other];
}

- (BOOL)isEqualToGlNamespace:(GLNamespace *)glNamespace {
    if (self == glNamespace)
        return YES;
    if (glNamespace == nil)
        return NO;
    if (self.namespaceId != glNamespace.namespaceId)
        return NO;
    if (self.name != glNamespace.name && ![self.name isEqualToString:glNamespace.name])
        return NO;
    if (self.path != glNamespace.path && ![self.path isEqualToString:glNamespace.path])
        return NO;
    if (self.namespaceDescription != glNamespace.namespaceDescription && ![self.namespaceDescription isEqualToString:glNamespace.namespaceDescription])
        return NO;
    if (self.createdAt != glNamespace.createdAt && ![self.createdAt isEqualToDate:glNamespace.createdAt])
        return NO;
    if (self.updatedAt != glNamespace.updatedAt && ![self.updatedAt isEqualToDate:glNamespace.updatedAt])
        return NO;
    if (self.ownerId != glNamespace.ownerId)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.namespaceId;
    hash = hash * 31u + [self.name hash];
    hash = hash * 31u + [self.path hash];
    hash = hash * 31u + [self.namespaceDescription hash];
    hash = hash * 31u + [self.createdAt hash];
    hash = hash * 31u + [self.updatedAt hash];
    hash = hash * 31u + (NSUInteger) self.ownerId;
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.namespaceId=%qi", self.namespaceId];
    [description appendFormat:@", self.name=%@", self.name];
    [description appendFormat:@", self.path=%@", self.path];
    [description appendFormat:@", self.namespaceDescription=%@", self.namespaceDescription];
    [description appendFormat:@", self.createdAt=%@", self.createdAt];
    [description appendFormat:@", self.updatedAt=%@", self.updatedAt];
    [description appendFormat:@", self.ownerId=%qi", self.ownerId];
    [description appendString:@">"];
    return description;
}

- (NSDictionary *)jsonRepresentation
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSNull *null = [NSNull null];
    return @{
             kKeyNamespaceId: @(_namespaceId),
             kKeyName: _name ?: null,
             kKeyPath: _path ?: null,
             kKeyDescription: _namespaceDescription ?: null,
             kKeyCreatedAt: [formatter stringFromDate:_createdAt],
             kKeyUpdatedAt: [formatter stringFromDate:_updatedAt],
             kKeyOwnerId: @(_ownerId)
             };
}

@end
