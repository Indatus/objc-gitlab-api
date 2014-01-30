//
//  GLMergeRequest.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLBaseObject.h"

@class GLUser, GLBranch;

@interface GLMergeRequest : GLBaseObject

// id
@property (nonatomic, assign) int64_t mergeRequestId;
// iid
@property (nonatomic, assign) int64_t mergeRequestIid;
// title
@property (nonatomic, copy) NSString *title;
// state
@property (nonatomic, copy) NSString *state;
// author
@property (nonatomic, strong) GLUser *author;
// assignee
@property (nonatomic, strong) GLUser *assignee;
// target_branch
@property (nonatomic, copy) NSString *targetBranch;
// source_branch
@property (nonatomic, copy) NSString *sourceBranch;
// project_id
@property (nonatomic, assign) int64_t projectId;
// upvotes
@property (nonatomic, assign) int32_t upvotes;
// downvotes
@property (nonatomic, assign) int32_t downvotes;

- (BOOL)isEqualToRequest:(GLMergeRequest *)request;

@end
