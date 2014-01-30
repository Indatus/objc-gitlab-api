//
//  GLProjectTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/30/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLGitlabApi.h"
#import "GLProject.h"
#import "GLUser.h"
#import "GLNamespace.h"

@interface GLProjectTests : XCTestCase

@end

@implementation GLProjectTests

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

- (void)testProjectJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSDictionary *projectJson = [GLTestUtility loadJsonFile:@"project"];
    
    GLProject *testProject = [[GLProject alloc] initWithJSON:projectJson];
    GLProject *knownProject = [GLProject new];
    knownProject.projectId = 4;
    knownProject.defaultBranch = @"master";
    knownProject.publicProject = NO;
    knownProject.visibilityLevel = 0;
    knownProject.sshUrl = @"git@example.com:diaspora/diaspora-client.git";
    knownProject.httpUrl = @"http://example.com/diaspora/diaspora-client.git";
    knownProject.webUrl = @"http://example.com/diaspora/diaspora-client";
    knownProject.owner = [GLUser new];
    knownProject.owner.userId = 3;
    knownProject.owner.name = @"Diaspora";
    knownProject.owner.createdAt = [formatter dateFromString:@"2013-09-30T13:46:02Z"];
    knownProject.name = @"Diaspora Client";
    knownProject.nameWithNamespace = @"Diaspora / Diaspora Client";
    knownProject.path = @"diaspora-client";
    knownProject.pathWithNamespace = @"diaspora/diaspora-client";
    knownProject.issuesEnabled = YES;
    knownProject.mergeRequestsEnabled = YES;
    knownProject.wallEnabled = NO;
    knownProject.wikiEnabled = YES;
    knownProject.snippetsEnabled = NO;
    knownProject.createdAt = [formatter dateFromString:@"2013-09-30T13:46:02Z"];
    knownProject.lastActivityAt = [formatter dateFromString:@"2013-09-30T13:46:02Z"];
    knownProject.glNamespace = [GLNamespace new];
    knownProject.glNamespace.createdAt = [formatter dateFromString:@"2013-09-30T13:46:02Z"];
    knownProject.glNamespace.namespaceDescription = @"";
    knownProject.glNamespace.namespaceId = 3;
    knownProject.glNamespace.name = @"Diaspora";
    knownProject.glNamespace.ownerId = 1;
    knownProject.glNamespace.path = @"diaspora";
    knownProject.glNamespace.updatedAt = [formatter dateFromString:@"2013-09-30T13:46:02Z"];
    
    XCTAssertEqualObjects(knownProject, testProject, @"Project initialized from JSON improperly");
    
}

@end
