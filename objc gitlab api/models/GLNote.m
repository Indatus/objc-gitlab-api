//
//  GLNote.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLNote.h"
#import "GLUser.h"
#import "GLGitlabApi.h"

static NSString * const kKeyNoteId = @"id";
static NSString * const kKeyBody = @"body";
static NSString * const kKeyAttachment = @"attachment";
static NSString * const kKeyAuthor = @"author";
static NSString * const kKeyCreatedAt = @"created_at";

@implementation GLNote

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _noteId = [json[kKeyNoteId] longLongValue];
        _body = [self checkForNull:json[kKeyBody]];
        _attachment = [self checkForNull:json[kKeyAttachment]];
        _author = [[GLUser alloc] initWithJSON:json[kKeyAuthor]];
        _createdAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyCreatedAt]];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToNote:other];
}

- (BOOL)isEqualToNote:(GLNote *)note {
    if (self == note)
        return YES;
    if (note == nil)
        return NO;
    if (self.noteId != note.noteId)
        return NO;
    if (self.body != note.body && ![self.body isEqualToString:note.body])
        return NO;
    if (self.attachment != note.attachment && ![self.attachment isEqualToString:note.attachment])
        return NO;
    if (self.author != note.author && ![self.author isEqualToUser:note.author])
        return NO;
    if (self.createdAt != note.createdAt && ![self.createdAt isEqualToDate:note.createdAt])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.noteId;
    hash = hash * 31u + [self.body hash];
    hash = hash * 31u + [self.attachment hash];
    hash = hash * 31u + [self.author hash];
    hash = hash * 31u + [self.createdAt hash];
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.noteId=%qi", self.noteId];
    [description appendFormat:@", self.body=%@", self.body];
    [description appendFormat:@", self.attachment=%@", self.attachment];
    [description appendFormat:@", self.author=%@", self.author];
    [description appendFormat:@", self.createdAt=%@", self.createdAt];
    [description appendString:@">"];
    return description;
}

- (NSDictionary *)jsonRepresentation
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSNull *null = [NSNull null];
    return @{
             kKeyNoteId: @(_noteId),
             kKeyBody: _body ?: null,
             kKeyAttachment: _attachment ?: null,
             kKeyAuthor: [_author jsonRepresentation],
             kKeyCreatedAt: [formatter stringFromDate:_createdAt]
             };
}

@end
