//
//  GLNamespace.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLNamespace : NSObject

@property (nonatomic, assign) int64_t namespaceId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *description;
// created_at
@property (nonatomic, strong) NSDate *createdAt;
// updated_at
@property (nonatomic, strong) NSDate *updatedAt;
// owner_id
@property (nonatomic, assign) int64_t ownerId;

@end
