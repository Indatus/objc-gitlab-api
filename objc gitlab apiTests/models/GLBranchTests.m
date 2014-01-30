//
//  GLBranchTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/28/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLGitlabApi.h"
#import "GLBranch.h"
#import "GLCommit.h"

@interface GLBranchTests : XCTestCase

@end

@implementation GLBranchTests

- (void)testBranchJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSDictionary *jsonDict = [GLTestUtility loadJsonFile:@"branch"];
    GLBranch *knownBranch = [[GLBranch alloc] init];
    knownBranch.name = @"master";
    knownBranch.commit = [[GLCommit alloc] init];
    knownBranch.commit.sha = @"7b5c3cc8be40ee161ae89a06bba6229da1032a0c";
    knownBranch.commit.shortId = @"7b5c3cc8be4";
    knownBranch.commit.authorName = @"John Smith";
    knownBranch.commit.authorEmail = @"john@example.com";
    knownBranch.commit.title = @"add projects API";
    knownBranch.commit.createdAt = [formatter dateFromString:@"2012-06-28T03:44:20-07:00"];
    knownBranch.branchProtected = YES;
    
    GLBranch *testBranch = [[GLBranch alloc] initWithJSON:jsonDict];
    
    XCTAssertEqualObjects(knownBranch, testBranch, @"Branch initialized from JSON incorrectly");
}

@end
