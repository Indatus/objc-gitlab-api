//
//  GLCommit.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLJsonInit.h"

@interface GLCommit : NSObject <GLJsonInit>

//id
@property (nonatomic, copy) NSString *sha;
//title
@property (nonatomic, copy) NSString *title;
// short_id
@property (nonatomic, copy) NSString *shortId;
// author_name
@property (nonatomic, copy) NSString *authorName;
// author_email
@property (nonatomic, copy) NSString *authorEmail;    
// created_at
@property (nonatomic, copy) NSDate *createdAt;

- (instancetype)initWithJSON:(NSDictionary *)json;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToCommit:(GLCommit *)commit;

- (NSUInteger)hash;

- (NSString *)description;

@end
