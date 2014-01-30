//
//  GLNamespaceTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/30/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLGitlabApi.h"
#import "GLNamespace.h"

@interface GLNamespaceTests : XCTestCase

@end

@implementation GLNamespaceTests

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

- (void)testNamespaceJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSDictionary *namespaceJson = [GLTestUtility loadJsonFile:@"namespace"];
    
    GLNamespace *testNamespace = [[GLNamespace alloc] initWithJSON:namespaceJson];
    GLNamespace *knownNamespace = [GLNamespace new];
    knownNamespace.namespaceId = 3;
    knownNamespace.name = @"Diaspora";
    knownNamespace.ownerId = 1;
    knownNamespace.path = @"diaspora";
    knownNamespace.namespaceDescription = @"";
    knownNamespace.createdAt = [formatter dateFromString:@"2013-09-30T13:46:02Z"];
    knownNamespace.updatedAt = [formatter dateFromString:@"2013-09-30T13:46:02Z"];
    
    XCTAssertEqualObjects(knownNamespace, testNamespace, @"Initializing namespace from JSON failed");
}

@end
