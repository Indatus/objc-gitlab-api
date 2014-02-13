//
//  GLGroup.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGroup.h"

static NSString * const kId = @"id";
static NSString * const kName = @"name";
static NSString * const kPath = @"path";
static NSString * const kOwnerId = @"owner_id";

@implementation GLGroup

- (instancetype)initWithJSON:(NSDictionary *)json {

    if ((self = [super init])) {
        _groupId = [json[kId] longValue];
        _name = json[kName];
        _path = json[kPath];
        _ownerId = [json[kOwnerId] longValue];
    }

    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.groupId=%qi", self.groupId];
    [description appendFormat:@", self.name=%@", self.name];
    [description appendFormat:@", self.path=%@", self.path];
    [description appendFormat:@", self.ownerId=%qi", self.ownerId];
    [description appendString:@">"];
    return description;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToGroup:other];
}

- (BOOL)isEqualToGroup:(GLGroup *)group {
    if (self == group)
        return YES;
    if (group == nil)
        return NO;
    if (self.groupId != group.groupId)
        return NO;
    if (self.name != group.name && ![self.name isEqualToString:group.name])
        return NO;
    if (self.path != group.path && ![self.path isEqualToString:group.path])
        return NO;
    if (self.ownerId != group.ownerId)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.groupId;
    hash = hash * 31u + [self.name hash];
    hash = hash * 31u + [self.path hash];
    hash = hash * 31u + (NSUInteger) self.ownerId;
    return hash;
}

@end
