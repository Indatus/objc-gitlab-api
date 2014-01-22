//
//  GLCommit.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLCommit.h"
#import "GLGitlabApi.h"

static NSString * const kKeyForSha = @"id";
static NSString * const kKeyForTitle = @"title";
static NSString * const kKeyForShortId = @"short_id";
static NSString * const kKeyForAuthorName = @"author_name";
static NSString * const kKeyForAuthorEmail = @"author_email";
static NSString * const kKeyForCreatedAt = @"created_at";

@implementation GLCommit

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _sha = json[kKeyForSha];
        _title = json[kKeyForTitle];
        _shortId = json[kKeyForShortId];
        _authorName = json[kKeyForAuthorName];
        _authorEmail = json[kKeyForAuthorEmail];
        _createdAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyForCreatedAt]];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToCommit:other];
}

- (BOOL)isEqualToCommit:(GLCommit *)commit {
    if (self == commit)
        return YES;
    if (commit == nil)
        return NO;
    if (self.sha != commit.sha && ![self.sha isEqualToString:commit.sha])
        return NO;
    if (self.title != commit.title && ![self.title isEqualToString:commit.title])
        return NO;
    if (self.shortId != commit.shortId && ![self.shortId isEqualToString:commit.shortId])
        return NO;
    if (self.authorName != commit.authorName && ![self.authorName isEqualToString:commit.authorName])
        return NO;
    if (self.authorEmail != commit.authorEmail && ![self.authorEmail isEqualToString:commit.authorEmail])
        return NO;
    if (self.createdAt != commit.createdAt && ![self.createdAt isEqualToDate:commit.createdAt])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.sha hash];
    hash = hash * 31u + [self.title hash];
    hash = hash * 31u + [self.shortId hash];
    hash = hash * 31u + [self.authorName hash];
    hash = hash * 31u + [self.authorEmail hash];
    hash = hash * 31u + [self.createdAt hash];
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.sha=%@", self.sha];
    [description appendFormat:@", self.title=%@", self.title];
    [description appendFormat:@", self.shortId=%@", self.shortId];
    [description appendFormat:@", self.authorName=%@", self.authorName];
    [description appendFormat:@", self.authorEmail=%@", self.authorEmail];
    [description appendFormat:@", self.createdAt=%@", self.createdAt];
    [description appendString:@">"];
    return description;
}

@end
