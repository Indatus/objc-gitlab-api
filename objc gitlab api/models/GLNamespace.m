//
//  GLNamespace.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLNamespace.h"
#import "GLGitlab.h"

NSString * const kKeyNamespaceId = @"id";
NSString * const kKeyName = @"name";
NSString * const kKeyPath = @"path";
NSString * const kKeyDescription = @"description";
NSString * const kKeyCreatedAt = @"created_at";
NSString * const kKeyUpdatedAt = @"updated_at";
NSString * const kKeyOwnerId = @"owner_id";

@implementation GLNamespace

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _namespaceId = [json[kKeyNamespaceId] longLongValue];
        _name = json[kKeyName];
        _path = json[kKeyPath];
        _description = json[kKeyDescription];
        _createdAt = [[[GLGitlab sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyCreatedAt]];
        _updatedAt = [[[GLGitlab sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyUpdatedAt]];
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
    if (self.description != glNamespace.description && ![self.description isEqualToString:glNamespace.description])
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
    hash = hash * 31u + [self.description hash];
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
    [description appendFormat:@", self.description=%@", self.description];
    [description appendFormat:@", self.createdAt=%@", self.createdAt];
    [description appendFormat:@", self.updatedAt=%@", self.updatedAt];
    [description appendFormat:@", self.ownerId=%qi", self.ownerId];
    [description appendString:@">"];
    return description;
}

@end
