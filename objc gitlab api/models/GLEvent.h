//
//  GLEvent.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/28/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLBaseObject.h"

@interface GLEvent : GLBaseObject

// title
@property (nonatomic, copy) NSString *title;
// project_id
@property (nonatomic, assign) int64_t projectId;
// action_name
@property (nonatomic, copy) NSString *actionName;
// target_id
@property (nonatomic, assign) int64_t targetId;
// target_type
@property (nonatomic, copy) NSString *targetType;
// author_id
@property (nonatomic, assign) int64_t authorId;
// data
@property (nonatomic, strong) NSDictionary *data;
// target_title
@property (nonatomic, copy) NSString *targetTitle;

- (BOOL)isEqualToEvent:(GLEvent *)event;

@end
