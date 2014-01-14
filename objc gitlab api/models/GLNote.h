//
//  GLNote.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const GLUserEndpoint;

@class GLUser;

@interface GLNote : NSObject

// id
@property (nonatomic, assign) int64_t noteId;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *attachment;
@property (nonatomic, strong) GLUser *author;
// created_at
@property (nonatomic, strong) NSDate *createdAt;

@end
