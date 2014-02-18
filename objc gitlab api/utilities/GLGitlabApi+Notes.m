//
//  GLGitlabApi+Notes.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Notes.h"
#import "GLGitlabApi+Private.h"
#import "GLIssue.h"
#import "GLMergeRequest.h"
#import "GLNote.h"

// Endpoints
static NSString * const kWallNotesEndpoint = @"/projects/%llu/notes";
static NSString * const kSingleWallNoteEndpoint = @"/projects/%llu/notes/%llu";
static NSString * const kIssueNotesEndpoint = @"/projects/%llu/issues/%llu/notes";
static NSString * const kSingleIssueNoteEndpoint = @"/projects/%llu/issues/%llu/notes/%llu";
static NSString * const kSnippetNotesEndpoint = @"/projects/%llu/snippets/%llu/notes";
static NSString * const kSingleSnippetNoteEndpoint = @"/projects/%llu/snippets/%llu/notes/%llu";
static NSString * const kMergeRequestNotesEndpoint = @"/projects/%llu/merge_requests/%llu/notes";
static NSString * const kSingleMergeRequestNoteEndpoint = @"/projects/%llu/merge_requests/%llu/notes/%llu";

// API Params
static NSString * const kParamBody = @"body";

@implementation GLGitlabApi (Notes)
#pragma mark - Notes Methods

- (GLNetworkOperation *)getWallNotesForProjectId:(int64_t)projectId
                                withSuccessBlock:(GLGitlabSuccessBlock)success
                                 andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kWallNotesEndpoint, projectId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self multipleObjectSuccessBlockForClass:[GLNote class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getWallNoteWithId:(int64_t)noteId
                             forProjectId:(int64_t)projectId
                         withSuccessBlock:(GLGitlabSuccessBlock)success
                          andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleWallNoteEndpoint, projectId, noteId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLNote class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createWallNoteForProjectId:(int64_t)projectId
                                          withBody:(NSString *)body
                                      successBlock:(GLGitlabSuccessBlock)success
                                   andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kWallNotesEndpoint, projectId]
                                                     method:GLNetworkOperationPostMethod];
    request.HTTPBody = [self urlEncodeParams:@{kParamBody: body}];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLNote class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getAllNotesForIssue:(GLIssue *)issue
                             withSuccessBlock:(GLGitlabSuccessBlock)success
                              andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kIssueNotesEndpoint, issue.projectId, issue.issueId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self multipleObjectSuccessBlockForClass:[GLNote class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getIssueNoteWithId:(int64_t)noteId
                                  forIssue:(GLIssue *)issue
                          withSuccessBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleIssueNoteEndpoint, issue.projectId, issue.issueId, noteId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLNote class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createNoteForIssue:(GLIssue *)issue
                                  withBody:(NSString *)body
                              successBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kIssueNotesEndpoint, issue.projectId, issue.issueId]
                                                     method:GLNetworkOperationPostMethod];
    request.HTTPBody = [self urlEncodeParams:@{kParamBody: body}];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLNote class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getAllNotesForMergeRequest:(GLMergeRequest *)mergeRequest
                                  withSuccessBlock:(GLGitlabSuccessBlock)success
                                   andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kMergeRequestNotesEndpoint, mergeRequest.projectId, mergeRequest.mergeRequestId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self multipleObjectSuccessBlockForClass:[GLNote class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)getNoteWithId:(int64_t)noteId
                      forMergeRequest:(GLMergeRequest *)mergeRequest
                     withSuccessBlock:(GLGitlabSuccessBlock)success
                      andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kSingleMergeRequestNoteEndpoint, mergeRequest.projectId, mergeRequest.mergeRequestId, noteId]
                                                     method:GLNetworkOperationGetMethod];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLNote class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}

- (GLNetworkOperation *)createNoteForMergeRequest:(GLMergeRequest *)mergeRequest
                                         withBody:(NSString *)body
                                     successBlock:(GLGitlabSuccessBlock)success
                                  andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request = [self requestForEndPoint:[NSString stringWithFormat:kMergeRequestNotesEndpoint, mergeRequest.projectId, mergeRequest.mergeRequestId]
                                                     method:GLNetworkOperationPostMethod];
    request.HTTPBody = [self urlEncodeParams:@{kParamBody: body}];
    
    GLNetworkOperationSuccessBlock localSuccessBlock = [self singleObjectSuccessBlockForClass:[GLNote class] successBlock:success];
    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];
    
    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}


@end
