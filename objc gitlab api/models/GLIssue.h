//
//  GLIssue.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/16/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLJsonInit.h"

@class GLUser, GLMilestone;

@interface GLIssue : NSObject <GLJsonInit>

// id
@property (nonatomic, assign) int64_t issueId;
// iid
@property (nonatomic, assign) int64_t issueIid;
// project_id
@property (nonatomic, assign) int64_t projectId;
// title
@property (nonatomic, copy) NSString *title;
// description
@property (nonatomic, copy) NSString *description;
// labels
@property (nonatomic, strong) NSArray *labels;
// milestone
@property (nonatomic, strong) GLMilestone *milestone;
// assignee
@property (nonatomic, strong) GLUser *assignee;
// author
@property (nonatomic, strong) GLUser *author;
// state
@property (nonatomic, copy) NSString *state;
// updated_at
@property (nonatomic, strong) NSDate *updatedAt;
// created_at
@property (nonatomic, strong) NSDate *createdAt;

- (instancetype)initWithJSON:(NSDictionary *)json;

- (NSDictionary *)jsonRepresentation;
- (NSDictionary *)jsonCreateRepresentation;

- (BOOL)isEqual:(id)other;
- (BOOL)isEqualToIssue:(GLIssue *)issue;
- (NSUInteger)hash;
- (NSString *)description;

@end
