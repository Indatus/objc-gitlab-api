//
//  GLGitlab.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GLGitlabSuccessBlock)(id responseObject);
typedef void (^GLGitlabFailureBlock)(NSError *error);

@class GLNetworkOperation, GLUser, GLMergeRequest, GLProject, GLNote, GLDiff;

@interface GLGitlab : NSObject

+ (GLGitlab *)sharedInstance;

- (NSDateFormatter *)gitLabDateFormatter;
- (GLNetworkOperation *)loginToHost:(NSString *)host
                           username:(NSString *)username
                           password:(NSString *)password
                            success:(GLGitlabSuccessBlock)successBlock
                            failure:(GLGitlabFailureBlock)failureBlock;

#pragma mark - Merge Request
- (GLNetworkOperation *)getMergeRequestsForProjectId:(int64_t)projectId withSuccessBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getMergeRequestWithId:(int64_t)mergeRequestId successBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)createMergeRequestForProjectId:(int64_t)projectId withMergeRequest:(GLMergeRequest *)mergeRequest successBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)updateMergeRequestForProjectId:(int64_t)projectId withMergeRequest:(GLMergeRequest *)mergeRequest successBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;

#pragma mark - Notes
// Project/wall notes
- (GLNetworkOperation *)getWallNotesForProjectId:(int64_t)projectId withSuccessBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getWallNoteWithId:(int64_t)noteId forProjectId:(int64_t)projectId withSuccessBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)createWallNoteForProjectId:(int64_t)projectId withBody:(NSString *)body successBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
// Issue notes
- (GLNetworkOperation *)getAllNotesForIssueId:(int64_t)issueId withSuccessBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getIssueNoteWithId:(int64_t)noteId forIssueId:(int64_t)issueId withSuccessBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)createNoteForIssueId:(int64_t)issueId withBody:(NSString *)body successBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
// Merge request notes
- (GLNetworkOperation *)getAllNotesForMergeRequestId:(int64_t)mergeRequestId withSuccessBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)getNoteWithId:(int64_t)noteId forMergeRequestId:(int64_t)mergeRequestId withSuccessBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;
- (GLNetworkOperation *)createNoteForMergeRequestId:(int64_t)mergeRequestId withBody:(NSString *)body successBlock:(GLGitlabSuccessBlock)success andFailureBlock:(GLGitlabFailureBlock)failure;


@end
