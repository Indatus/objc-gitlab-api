//
//  GLSnippet.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLJsonInit.h"

@class GLUser;

@interface GLSnippet : NSObject <GLJsonInit>

// id
@property (nonatomic, assign) int64_t snippetId;
// title
@property (nonatomic, copy) NSString *title;
// file_name
@property (nonatomic, copy) NSString *file_name;
// author
@property (nonatomic, strong) GLUser *author;
// expires_at
@property (nonatomic, strong) NSDate *expiresAt;
// updated_at
@property (nonatomic, strong) NSDate *updatedAt;
// created_at
@property (nonatomic, strong) NSDate *createdAt;

- (instancetype)initWithJSON:(NSDictionary *)json;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToSnippet:(GLSnippet *)snippet;

- (NSUInteger)hash;

- (NSString *)description;

@end
