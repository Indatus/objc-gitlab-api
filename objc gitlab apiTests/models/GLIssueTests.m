//
//  GLIssueTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/29/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLIssue.h"
#import "GLUser.h"
#import "GLMilestone.h"
#import "GLGitlabApi.h"

@interface GLIssueTests : XCTestCase

@end

@implementation GLIssueTests

- (void)testIssueJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSDateFormatter *dueDateFormatter = [[GLGitlabApi sharedInstance] dueDateFormatter];
    NSArray *jsonObject = [GLTestUtility loadJsonFile:@"issues"];
    
    GLUser *author = [GLUser new];
    author.userId = 1;
    author.username = @"john_smith";
    author.email = @"john@example.com";
    author.name = @"John Smith";
    author.state = @"active";
    author.createdAt = [formatter dateFromString:@"2012-05-23T08:00:58Z"];
    
    GLIssue *knownIssueOne = [GLIssue new];
    knownIssueOne.issueId = 43;
    knownIssueOne.issueIid = 3;
    knownIssueOne.projectId = 8;
    knownIssueOne.title = @"4xx/5xx pages";
    knownIssueOne.issueDescription = @"";
    knownIssueOne.labels = @[];
    knownIssueOne.author = author;
    knownIssueOne.state = @"closed";
    knownIssueOne.updatedAt = [formatter dateFromString:@"2012-07-02T17:53:12Z"];
    knownIssueOne.createdAt = [formatter dateFromString:@"2012-07-02T17:53:12Z"];
    
    GLMilestone *milestone = [GLMilestone new];
    milestone.milestoneId = 1;
    milestone.title = @"v1.0";
    milestone.milestoneDescription = @"";
    milestone.dueDate = [dueDateFormatter dateFromString:@"2012-07-20"];
    milestone.state = @"reopened";
    milestone.updatedAt = [formatter dateFromString:@"2012-07-04T13:42:48Z"];
    milestone.createdAt = [formatter dateFromString:@"2012-07-04T13:42:48Z"];

    GLUser *assignee = [GLUser new];
    assignee.userId = 2;
    assignee.username = @"jack_smith";
    assignee.email = @"jack@example.com";
    assignee.name = @"Jack Smith";
    assignee.state = @"active";
    assignee.createdAt = [formatter dateFromString:@"2012-05-23T08:01:01Z"];
    
    
    GLIssue *knownIssueTwo = [GLIssue new];
    knownIssueTwo.issueId = 42;
    knownIssueTwo.issueIid = 4;
    knownIssueTwo.projectId = 8;
    knownIssueTwo.title = @"Add user settings";
    knownIssueTwo.issueDescription = @"";
    knownIssueTwo.labels = @[@"feature"];
    knownIssueTwo.author = author;
    knownIssueTwo.milestone = milestone;
    knownIssueTwo.assignee = assignee;
    knownIssueTwo.state = @"opened";
    knownIssueTwo.updatedAt = [formatter dateFromString:@"2012-07-12T13:43:19Z"];
    knownIssueTwo.createdAt = [formatter dateFromString:@"2012-06-28T12:58:06Z"];
    
    NSMutableArray *testObjects = [NSMutableArray arrayWithCapacity:jsonObject.count];
    for (NSDictionary *dict in jsonObject) {
        GLIssue *issue = [[GLIssue alloc] initWithJSON:dict];
        [testObjects addObject:issue];
    }
    
    XCTAssertNotNil(jsonObject, @"Json object didn't load");
    XCTAssertEqualObjects(knownIssueOne, testObjects[0], @"Issue initialized from JSON incorrectly");
    XCTAssertEqualObjects(knownIssueTwo, testObjects[1], @"Issue initialized from JSON incorrectly");
}

@end
