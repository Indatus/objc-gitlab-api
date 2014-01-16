//
//  GLCommit.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLCommit.h"

NSString * const GLCommitEndPoint = @"/commits";

NSString * const kKeyForSha = @"id";
NSString * const kKeyForTitle = @"title";
NSString * const kKeyForShortId = @"short_id";
NSString * const kKeyForAuthorName = @"author_name";
NSString * const kKeyForAuthorEmail = @"author_email";
NSString * const kKeyForCreatedAt = @"created_at";

@implementation GLCommit

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _sha = json[kKeyForSha];
        _title = json[kKeyForTitle];
        _shortId = json[kKeyForShortId];
        _authorName = json[kKeyForAuthorName];
        _authorEmail = json[kKeyForAuthorEmail];
        
        // TODO: createdAt
    }
    
    return self;
}

@end
