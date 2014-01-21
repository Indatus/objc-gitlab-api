//
//  GLGitlab.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlab.h"
#import "GLNetworkOperation.h"
#import "GLJsonInit.h"
#import "GLProject.h"
#import "GLUser.h"
#import "GLMergeRequest.h"
#import "GLProject.h"
#import "GLNote.h"
#import "GLDiff.h"

static NSString *const kPostMethod = @"post";
static NSString *const kGetMethod = @"get";
static NSString *const kPutMethod = @"put";
static NSString *const kApiRoutePrefix = @"/api/v3";
static NSString *const kLoginRoute = @"/session";

// Request Keys
static NSString *const kLoginUsernameKey = @"login";
static NSString *const kLoginPasswordKey = @"password";

// Response Keys
static NSString *const kPrivateTokenKey = @"private_token";

@interface GLGitlab ()

@property (nonatomic, strong) NSURL *hostName;
@property (nonatomic, strong) NSString *privateToken;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSOperationQueue  *queue;
@end

@implementation GLGitlab

static GLGitlab *_instance;

- (instancetype)init
{
    if ((self = [super init]))
    {
        _queue = [[NSOperationQueue alloc] init];
        _queue.name = @"GitLab Operations";
        [_queue setSuspended:NO];
        // GitLab Date String: 2012-05-23T08:00:58Z
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setDateFormat:@"yyyy-MM-d'T'hh:mm:ssZ"];
    }
    
    return self;
}

+ (GLGitlab *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[GLGitlab alloc] init];
    });
    
    return _instance;
}

- (NSDateFormatter *)gitLabDateFormatter
{
    return _dateFormatter;
}


#pragma mark - Login Methods

- (GLNetworkOperation *)loginToHost:(NSString *)host
                           username:(NSString *)username
                           password:(NSString *)password
                            success:(GLGitlabSuccessBlock)successBlock
                            failure:(GLGitlabFailureBlock)failureBlock
{
    self.hostName = [NSURL URLWithString:host];

    NSURL *requestUrl = [self requestUrlForEndPoint:kLoginRoute];
    NSDictionary *params = @{ kLoginUsernameKey: username, kLoginPasswordKey: password };
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    NSError *error;
    
    request.HTTPMethod = kPostMethod;
    request.HTTPBody = [self urlEncodeParams:params];
    if (error) {
        NSLog(@"Error serializing login params: %@", error.localizedDescription);
        failureBlock(error);
        return nil;
    }
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        self.privateToken = responseObject[kPrivateTokenKey];
        GLUser *user = [[GLUser alloc] initWithJSON:responseObject];
        successBlock(user);
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        failureBlock(error);
    };
    
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}


#pragma mark - Project Methods

- (GLNetworkOperation *)getUsersProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                        failure:(GLGitlabFailureBlock)failureBlock
{
    return nil;
}

- (GLNetworkOperation *)getUsersOwnedProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                             failure:(GLGitlabFailureBlock)failureBlock
{
    return nil;
}

- (GLNetworkOperation *)getAllProjectsSuccess:(GLGitlabSuccessBlock)successBlock
                                      failure:(GLGitlabFailureBlock)failureBlock
{
    return nil;
}

- (GLNetworkOperation *)getProjectWithId:(int64_t)projectId
                                 success:(GLGitlabSuccessBlock)successBlock
                                 failure:(GLGitlabFailureBlock)failureBlock
{
    return nil;
}

- (GLNetworkOperation *)getProjectEventsForProject:(GLProject *)project
                                           success:(GLGitlabSuccessBlock)successBlock
                                           failure:(GLGitlabFailureBlock)failureBlock
{
    return [self getProjectEventsForProjectId:project.projectId
                                      success:successBlock
                                      failure:failureBlock];
}

- (GLNetworkOperation *)getProjectEventsForProjectId:(int64_t)projectId
                                             success:(GLGitlabSuccessBlock)successBlock
                                             failure:(GLGitlabFailureBlock)failureBlock
{
    return nil;
}

- (GLNetworkOperation *)createProjectNamed:(NSString *)projectName
                                   success:(GLGitlabSuccessBlock)successBlock
                                   failure:(GLGitlabFailureBlock)failureBlock
{
    return nil;
}

- (GLNetworkOperation *)createProjectNamed:(NSString *)projectName
                                   forUser:(GLUser *)user
                                   success:(GLGitlabSuccessBlock)successBlock
                                   failure:(GLGitlabFailureBlock)failureBlock
{
    return nil;
}


#pragma mark - MergeRequest Methods

- (GLNetworkOperation *)getMergeRequestsForProjectId:(int64_t)projectId
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)getMergeRequestWithId:(int64_t)mergeRequestId
                                 successBlock:(GLGitlabSuccessBlock)success
                              andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)createMergeRequestForProjectId:(int64_t)projectId
                                      withMergeRequest:(GLMergeRequest *)mergeRequest
                                          successBlock:(GLGitlabSuccessBlock)success
                                       andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPostMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)updateMergeRequestForProjectId:(int64_t)projectId
                                      withMergeRequest:(GLMergeRequest *)mergeRequest
                                          successBlock:(GLGitlabSuccessBlock)success
                                       andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPutMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}


#pragma mark - Notes Methods

- (GLNetworkOperation *)getWallNotesForProjectId:(int64_t)projectId
                                withSuccessBlock:(GLGitlabSuccessBlock)success
                                 andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)getWallNoteWithId:(int64_t)noteId
                             forProjectId:(int64_t)projectId
                         withSuccessBlock:(GLGitlabSuccessBlock)success
                          andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)createWallNoteForProjectId:(int64_t)projectId
                                          withBody:(NSString *)body
                                      successBlock:(GLGitlabSuccessBlock)success
                                   andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPostMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)getAllNotesForIssueId:(int64_t)issueId
                             withSuccessBlock:(GLGitlabSuccessBlock)success
                              andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)getIssueNoteWithId:(int64_t)noteId
                                forIssueId:(int64_t)issueId
                          withSuccessBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

// POST
- (GLNetworkOperation *)createNoteForIssueId:(int64_t)issueId
                                    withBody:(NSString *)body
                                successBlock:(GLGitlabSuccessBlock)success
                             andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPostMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)getAllNotesForMergeRequestId:(int64_t)mergeRequestId
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)getNoteWithId:(int64_t)noteId
                    forMergeRequestId:(int64_t)mergeRequestId
                     withSuccessBlock:(GLGitlabSuccessBlock)success
                      andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)createNoteForMergeRequestId:(int64_t)mergeRequestId
                                           withBody:(NSString *)body
                                       successBlock:(GLGitlabSuccessBlock)success
                                    andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPostMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}


#pragma mark - Issues Methods

- (GLNetworkOperation *)getAllIssuesWithSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)getAllIssuesForProjectId:(int64_t)projectId
                                withSuccessBlock:(GLGitlabSuccessBlock)success
                                 andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)getIssueWithId:(int64_t)issueId
                          forProjectId:(int64_t)projectId
                      withSuccessBlock:(GLGitlabSuccessBlock)success
                       andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)createIssue:(GLIssue *)issue
                       forProjectId:(int64_t)projectId
                   withSuccessBlock:(GLGitlabSuccessBlock)success
                    andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPostMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)updateIssue:(GLIssue *)issue
                   withSuccessBlock:(GLGitlabSuccessBlock)success
                    andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPutMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)closeIssue:(GLIssue *)issue
                  withSuccessBlock:(GLGitlabSuccessBlock)success
                   andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPutMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)reopenIssue:(GLIssue *)issue
                   withSuccessBlock:(GLGitlabSuccessBlock)success
                    andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPutMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}


#pragma mark - Milestone Methods

- (GLNetworkOperation *)getAllMilestonesForProjectId:(int64_t)projectId
                                    withSuccessBlock:(GLGitlabSuccessBlock)success
                                     andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)getMilestoneWithId:(int64_t)milestoneId
                              forProjectId:(int64_t)projectId
                          withSuccessBlock:(GLGitlabSuccessBlock)success
                           andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)createMilestone:(GLMilestone *)milestone forProjectId:(int64_t)projectId
                       withSuccessBlock:(GLGitlabSuccessBlock)success
                        andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPostMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)updateMilestone:(GLMilestone *)milestone
                       withSuccessBlock:(GLGitlabSuccessBlock)success
                        andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPutMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)closeMilestone:(GLMilestone *)milestone
                      withSuccessBlock:(GLGitlabSuccessBlock)success
                       andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPutMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}

- (GLNetworkOperation *)activateMilestone:(GLMilestone *)milestone
                         withSuccessBlock:(GLGitlabSuccessBlock)success
                          andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kPutMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}


#pragma mark - Commit Methods

- (GLNetworkOperation *)getAllCommitsForProjectId:(int64_t)projectId
                                 withSuccessBlock:(GLGitlabSuccessBlock)success
                                  andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}
- (GLNetworkOperation *)getCommitWithSha:(NSString *)sha forProjectId:(int64_t)projectId
                        withSuccessBlock:(GLGitlabSuccessBlock)success
                         andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSMutableURLRequest *request;
    request.HTTPMethod = kGetMethod;
    
    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSDictionary *responseObject) {
        // TODO
    };
    
    GLNetworkOperationFailureBlock localFailureBlock = ^(NSError *error, NSInteger httpStatus, NSData *responseData) {
        // TODO
    };
    
    GLNetworkOperation *op = [[GLNetworkOperation alloc] initWithRequest:request
                                                                 success:localSuccessBlock
                                                                 failure:localFailureBlock];
    [_queue addOperation:op];
    
    return op;
}


#pragma mark - Private Methods

- (NSData *)urlEncodeParams:(NSDictionary *)params
{
    NSMutableArray *paramArray = [NSMutableArray array];
    [params enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *obj, BOOL *stop) {
        [paramArray addObject:[NSString stringWithFormat:@"%@=%@", key, [self percentEncodeString:obj]]];
    }];
    NSString *paramString = [paramArray componentsJoinedByString:@"&"];
    
    return [paramString dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)percentEncodeString:(NSString *)unencodedString
{
    NSString *encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                          NULL,
                                          (CFStringRef)unencodedString,
                                          NULL,
                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                          kCFStringEncodingUTF8 ));
    return encodedString;
}

- (NSArray *)processJsonArray:(NSArray *)jsonArray class:(Class)class
{
    if (![class conformsToProtocol:@protocol(GLJsonInit)]) {
        return nil;
    }
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dictionary in jsonArray) {
        id object = [[class alloc] initWithJSON:dictionary];
        [array addObject:object];
    }
    
    return [array copy];
}

- (NSURL *)requestUrlForEndPoint:(NSString *)endpoint
{
    NSURL *url = [_hostName URLByAppendingPathComponent:kApiRoutePrefix];
    url = [url URLByAppendingPathComponent:endpoint];
    return url;
}

@end
