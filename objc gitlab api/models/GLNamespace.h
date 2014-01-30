//
//  GLNamespace.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLBaseObject.h"

@interface GLNamespace : GLBaseObject

// id
@property (nonatomic, assign) int64_t namespaceId;
// name
@property (nonatomic, copy) NSString *name;
// path
@property (nonatomic, copy) NSString *path;
// description
@property (nonatomic, copy) NSString *namespaceDescription;
// created_at
@property (nonatomic, strong) NSDate *createdAt;
// updated_at
@property (nonatomic, strong) NSDate *updatedAt;
// owner_id
@property (nonatomic, assign) int64_t ownerId;

- (BOOL)isEqualToGlNamespace:(GLNamespace *)glNamespace;

@end
