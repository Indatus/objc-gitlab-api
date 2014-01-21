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

@end
