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
static NSString * const kKeyForMessage = @"message";
static NSString * const kKeyForShortId = @"short_id";
static NSString * const kKeyForAuthor = @"author";
static NSString * const kKeyForName = @"name";
static NSString * const kKeyForEmail = @"email";
static NSString * const kKeyForAuthorName = @"author_name";
static NSString * const kKeyForAuthorEmail = @"author_email";
static NSString * const kKeyForCreatedAt = @"created_at";
static NSString * const kKeyForCommittedDate = @"committed_date";
static NSString * const kKeyForParents = @"parents";

@implementation GLCommit

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _sha = [self checkForNull:json[kKeyForSha]];
        
        if (json[kKeyForTitle]) {
            _title = [self checkForNull:json[kKeyForTitle]];
        }
        else if (json[kKeyForMessage]) {
            _title = [self checkForNull:json[kKeyForMessage]];
        }
        
        if (json[kKeyForShortId]) {
            _shortId = [self checkForNull:json[kKeyForShortId]];
        }
        else if (_sha) {
            _shortId = [_sha substringToIndex:11];
        }
        
        if (json[kKeyForAuthorName]) {
            _authorName = [self checkForNull:json[kKeyForAuthorName]];
            _authorEmail = [self checkForNull:json[kKeyForAuthorEmail]];
        }
        else if (json[kKeyForAuthor]) {
            NSDictionary *authorData = json[kKeyForAuthor];
            _authorName = [self checkForNull:authorData[kKeyForName]];
            _authorEmail = [self checkForNull:authorData[kKeyForEmail]];
        }
        
        NSString *dateString;
        if (json[kKeyForCreatedAt]) {
            dateString = [self checkForNull:json[kKeyForCreatedAt]];
        }
        else if (json[kKeyForCommittedDate]) {
            dateString = [self checkForNull:json[kKeyForCommittedDate]];
        }
        
        if (dateString) {
            _createdAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:dateString];
        }
        
        if (json[kKeyForParents]) {
            _parents = [self checkForNull:json[kKeyForParents]];
        }
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

- (NSDictionary *)jsonRepresentation
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSNull *null = [NSNull null];
    return @{
             kKeyForSha: _sha ?: null,
             kKeyForTitle: _title ?: null,
             kKeyForShortId: _shortId ?: null,
             kKeyForAuthorName: _authorName ?: null,
             kKeyForAuthorEmail: _authorEmail ?: null,
             kKeyForCreatedAt: [formatter stringFromDate:_createdAt]
             };
}

@end
