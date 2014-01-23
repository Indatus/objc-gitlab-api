//
//  GLGitlabApi+Notes.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"

@class GLIssue, GLMergeRequest;

@interface GLGitlabApi (Notes)
// Project/wall notes
- (GLNetworkOperation *)getWallNotesForProjectId:(int64_t)projectId
                                withSuccessBlock:(GLGitlabSuccessBlock)success
                                 andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)getWallNoteWithId:(int64_t)noteId
                             forProjectId:(int64_t)projectId
                         withSuccessBlock:(GLGitlabSuccessBlock)success
                          andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)createWallNoteForProjectId:(int64_t)projectId
                                          withBody:(NSString *)body
                                      successBlock:(GLGitlabSuccessBlock)success
                                   andFailureBlock:(GLGitlabFailureBlock)failure;
// Issue notes
- (GLNetworkOperation *)getAllNotesForIssue:(GLIssue *)issue
                             withSuccessBlock:(GLGitlabSuccessBlock)success
                              andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)getIssueNoteWithId:(int64_t)noteId
                                  forIssue:(GLIssue *)issue
                          withSuccessBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)createNoteForIssue:(GLIssue *)issue
                                  withBody:(NSString *)body
                              successBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure;
// Merge request notes
- (GLNetworkOperation *)getAllNotesForMergeRequest:(GLMergeRequest *)mergeRequest
                                  withSuccessBlock:(GLGitlabSuccessBlock)success
                                   andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)getNoteWithId:(int64_t)noteId
                      forMergeRequest:(GLMergeRequest *)mergeRequest
                     withSuccessBlock:(GLGitlabSuccessBlock)success
                      andFailureBlock:(GLGitlabFailureBlock)failure;

- (GLNetworkOperation *)createNoteForMergeRequest:(GLMergeRequest *)mergeRequest
                                         withBody:(NSString *)body
                                     successBlock:(GLGitlabSuccessBlock)success
                                  andFailureBlock:(GLGitlabFailureBlock)failure;


@end
