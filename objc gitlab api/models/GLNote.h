//
//  GLNote.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLBaseObject.h"

@class GLUser;

@interface GLNote : GLBaseObject

// id
@property (nonatomic, assign) int64_t noteId;
// body
@property (nonatomic, copy) NSString *body;
// attachment
@property (nonatomic, copy) NSString *attachment;
// author
@property (nonatomic, strong) GLUser *author;
// created_at
@property (nonatomic, strong) NSDate *createdAt;

- (BOOL)isEqualToNote:(GLNote *)note;

@end
