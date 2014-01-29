//
//  GLSnippet.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLSnippet.h"
#import "GLGitlabApi.h"
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
        NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
        _snippetId = [json[kSnippetId] longLongValue];
        _title = [self checkForNull:json[kTitle]];
        _file_name = [self checkForNull:json[kFileName]];
        _author = [[GLUser alloc] initWithJSON:json[kAuthor]];
        NSString *expiresString = [self checkForNull:json[kExpiresAt]];
        if (expiresString) {
            _expiresAt = [formatter dateFromString:expiresString];
        }
        
        _updatedAt = [formatter dateFromString:json[kUpdatedAt]];
        _createdAt = [formatter dateFromString:json[kCreatedAt]];
    }
    
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToSnippet:other];
}

- (BOOL)isEqualToSnippet:(GLSnippet *)snippet {
    if (self == snippet)
        return YES;
    if (snippet == nil)
        return NO;
    if (self.snippetId != snippet.snippetId)
        return NO;
    if (self.title != snippet.title && ![self.title isEqualToString:snippet.title])
        return NO;
    if (self.file_name != snippet.file_name && ![self.file_name isEqualToString:snippet.file_name])
        return NO;
    if (self.author != snippet.author && ![self.author isEqualToUser:snippet.author])
        return NO;
    if (self.expiresAt != snippet.expiresAt && ![self.expiresAt isEqualToDate:snippet.expiresAt])
        return NO;
    if (self.updatedAt != snippet.updatedAt && ![self.updatedAt isEqualToDate:snippet.updatedAt])
        return NO;
    if (self.createdAt != snippet.createdAt && ![self.createdAt isEqualToDate:snippet.createdAt])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.snippetId;
    hash = hash * 31u + [self.title hash];
    hash = hash * 31u + [self.file_name hash];
    hash = hash * 31u + [self.author hash];
    hash = hash * 31u + [self.expiresAt hash];
    hash = hash * 31u + [self.updatedAt hash];
    hash = hash * 31u + [self.createdAt hash];
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.snippetId=%qi", self.snippetId];
    [description appendFormat:@", self.title=%@", self.title];
    [description appendFormat:@", self.file_name=%@", self.file_name];
    [description appendFormat:@", self.author=%@", self.author];
    [description appendFormat:@", self.expiresAt=%@", self.expiresAt];
    [description appendFormat:@", self.updatedAt=%@", self.updatedAt];
    [description appendFormat:@", self.createdAt=%@", self.createdAt];
    [description appendString:@">"];
    return description;
}

- (NSDictionary *)jsonRepresentation
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSNull *null = [NSNull null];
    
    return @{
             kSnippetId: @(_snippetId),
             kTitle: _title ?: null,
             kFileName: _file_name ?: null,
             kAuthor: [_author jsonRepresentation],
             kExpiresAt: [formatter stringFromDate:_expiresAt] ?: null,
             kUpdatedAt: [formatter stringFromDate:_updatedAt],
             kCreatedAt: [formatter stringFromDate:_createdAt]
             };
}

@end
