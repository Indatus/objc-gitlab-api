//
//  GLSnippet.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLSnippet.h"
#import "GLGitlab.h"
#import "GLUser.h"

static NSString * const kSnippetId = @"id";
static NSString * const kTitle = @"title";
static NSString * const kFileName = @"file_name";
static NSString * const kAuthor = @"author";
static NSString * const kExpiresAt = @"expires_at";
static NSString * const kUpdatedAt = @"updated_at";
static NSString * const kCreatedAt = @"created_at";

@implementation GLSnippet

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        NSDateFormatter *formatter = [[GLGitlab sharedInstance] gitLabDateFormatter];
        _snippetId = [json[kSnippetId] longLongValue];
        _title = json[kTitle];
        _file_name = json[kFileName];
        _author = [[GLUser alloc] initWithJSON:json[kAuthor]];
        _expiresAt = json[kExpiresAt] == [NSNull null] ? nil : [formatter dateFromString:json[kExpiresAt]];
        _updatedAt = [formatter dateFromString:json[kUpdatedAt]];
        _createdAt = [formatter dateFromString:json[kCreatedAt]];
    }
    
    return self;
}

- (BOOL)isEqual:(id)other
{
    if (self == other) {
        return YES;
    }
    
    if (![other isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToSnippet:other];;
}

- (BOOL)isEqualToSnippet:(GLSnippet *)snippet
{
    return YES;
}

- (NSUInteger)hash
{
    return 0;
}

- (NSString *)description
{
    return nil;
}

@end
