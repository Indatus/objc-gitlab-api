//
//  GLMergeRequest.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString * const GLMergeRequestEndPoint;

@class GLUser;

@interface GLMergeRequest : NSObject
    
@property (nonatomic, assign) int64_t mergeRequestId;
@property (nonatomic, assign) int64_t mergeRequestIid;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, assign, getter = isClosed) BOOL closed;
@property (nonatomic, assign, getter = isMerged) BOOL merged;
@property (nonatomic, strong) GLUser *author;
@property (nonatomic, strong) GLUser *assignee;
// target_branch
@property (nonatomic, copy) NSString *targetBranch;
// source_branch
@property (nonatomic, copy) NSString *sourceBranch;
// project_id
@property (nonatomic, assign) int64_t projectId;
// source_project_id
@property (nonatomic, assign) int64_t sourceProjectId;

+ (GLMergeRequest *)getMergeRequest:(int64_t)mergeRequestId;
+ (NSArray *)getMergeRequestsForAuthor:(GLUser *)author;
+ (NSArray *)getMergeRequestsForAssignee:(GLUser *)assignee;
+ (NSArray *)getAllMergeRequests;

@end
