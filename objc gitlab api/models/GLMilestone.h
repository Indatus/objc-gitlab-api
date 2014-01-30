//
//  GLMilestone.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/16/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLBaseObject.h"

@interface GLMilestone : GLBaseObject

// id
@property (nonatomic, assign) int64_t milestoneId;
// iid
@property (nonatomic, assign) int64_t milestoneIid;
// project_id
@property (nonatomic, assign) int64_t projectId;
// title
@property (nonatomic, copy) NSString *title;
// description
@property (nonatomic, copy) NSString *milestoneDescription;
// due_date
@property (nonatomic, strong) NSDate *dueDate;
// state
@property (nonatomic, copy) NSString *state;
// updated_at
@property (nonatomic, strong) NSDate *updatedAt;
// created_at
@property (nonatomic, strong) NSDate *createdAt;

- (BOOL)isEqualToMilestone:(GLMilestone *)milestone;

@end
