//
//  GLGroup.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLBaseObject.h"

@interface GLGroup : GLBaseObject

// id
@property (nonatomic) int64_t groupId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic) int64_t ownerId;

- (NSString *)description;

- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToGroup:(GLGroup *)group;

- (NSUInteger)hash;

@end
