//
//  GLMergeRequestTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/30/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLMergeRequest.h"
#import "GLUser.h"
#import "GLGitlabApi.h"

@interface GLMergeRequestTests : XCTestCase

@end

@implementation GLMergeRequestTests

- (void)testMergeRequestJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSDictionary *mergeRequestJson = [GLTestUtility loadJsonFile:@"merge_request"];
    
    GLMergeRequest *knownMergeRequest = [GLMergeRequest new];
    knownMergeRequest.mergeRequestId = 1;
    knownMergeRequest.mergeRequestIid = 1;
    knownMergeRequest.targetBranch = @"master";
    knownMergeRequest.sourceBranch = @"test1";
    knownMergeRequest.projectId = 3;
    knownMergeRequest.title = @"test1";
    knownMergeRequest.state = @"merged";
    knownMergeRequest.upvotes = 0;
    knownMergeRequest.downvotes = 0;
    knownMergeRequest.author = [GLUser new];
    knownMergeRequest.author.userId = 1;
    knownMergeRequest.author.username = @"admin";
    knownMergeRequest.author.email = @"admin@local.host";
    knownMergeRequest.author.name = @"Administrator";
    knownMergeRequest.author.state = @"active";
    knownMergeRequest.author.createdAt = [formatter dateFromString:@"2012-04-29T08:46:00Z"];
    knownMergeRequest.assignee = knownMergeRequest.author;
    
    GLMergeRequest *testRequest = [[GLMergeRequest alloc] initWithJSON:mergeRequestJson];
    
    XCTAssertEqualObjects(knownMergeRequest, testRequest, @"Merge Request initialized from JSON incorrectly");
}

@end
