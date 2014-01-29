//
//  GLBranchTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/28/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLGitlabApi.h"
#import "GLBranch.h"
#import "GLCommit.h"

static NSString *const branchJson = @"{ \"name\": \"master\", \"commit\": { \"id\": \"7b5c3cc8be40ee161ae89a06bba6229da1032a0c\", \"parents\": [ { \"id\": \"4ad91d3c1144c406e50c7b33bae684bd6837faf8\" } ], \"tree\": \"46e82de44b1061621357f24c05515327f2795a95\", \"message\": \"add projects API\", \"author\": { \"name\": \"John Smith\", \"email\": \"john@example.com\" }, \"committer\": { \"name\": \"John Smith\", \"email\": \"john@example.com\" }, \"authored_date\": \"2012-06-27T05:51:39-07:00\", \"committed_date\": \"2012-06-28T03:44:20-07:00\" }, \"protected\": true }";

@interface GLBranchTests : XCTestCase

@end

@implementation GLBranchTests

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

- (void)testJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSData *jsonData = [branchJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:NSJSONReadingAllowFragments
                                                               error:nil];
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
    
    XCTAssertEqualObjects(knownBranch, testBranch, @"Branch JSON Parsed incorrectly");
}

@end
