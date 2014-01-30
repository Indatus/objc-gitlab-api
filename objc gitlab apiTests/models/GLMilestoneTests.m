//
//  GLMilestoneTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/30/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLMilestone.h"
#import "GLGitlabApi.h"

@interface GLMilestoneTests : XCTestCase

@end

@implementation GLMilestoneTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testMilestoneJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSDateFormatter *dueDateFormatter = [[GLGitlabApi sharedInstance] dueDateFormatter];
    NSDictionary *milestoneJson = [GLTestUtility loadJsonFile:@"milestone"];
    GLMilestone *knownMilestone = [GLMilestone new];
    knownMilestone.milestoneId = 12;
    knownMilestone.milestoneIid = 3;
    knownMilestone.projectId = 16;
    knownMilestone.title = @"10.0";
    knownMilestone.milestoneDescription = @"Version";
    knownMilestone.dueDate = [dueDateFormatter dateFromString:@"2013-11-29"];
    knownMilestone.state = @"active";
    knownMilestone.updatedAt = [formatter dateFromString:@"2013-10-02T09:24:18Z"];
    knownMilestone.createdAt = [formatter dateFromString:@"2013-10-02T09:24:18Z"];

    GLMilestone *testMilestone = [[GLMilestone alloc] initWithJSON:milestoneJson];
    
    XCTAssertEqualObjects(knownMilestone, testMilestone, @"Mileston failed to init with JSON");
}

@end
