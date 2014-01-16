//
//  GLNote.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLNote.h"
#import "GLUser.h"

NSString * const GLUserEndpoint = @"/notes";

NSString * const kKeyNoteId = @"id";
NSString * const kKeyBody = @"body";
NSString * const kKeyAttachment = @"attachment";
NSString * const kKeyAuthor = @"author";
NSString * const kKeyCreatedAt = @"created_at";

@implementation GLNote

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _noteId = [json[kKeyNoteId] longLongValue];
        _body = json[kKeyBody];
        _attachment = json[kKeyAttachment];
        _author = [[GLUser alloc] initWithJSON:json[kKeyAuthor]];
        // TOOD: createdAt
    }
    return self;
}

@end
