//
//  GLGroupTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLGroup.h"

@interface GLGroupTests : XCTestCase

@end

@implementation GLGroupTests

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

- (void)testGroupJsonInit
{
    NSDictionary *json = [GLTestUtility loadJsonFile:@"group"];
    GLGroup *testGroup = [[GLGroup alloc] initWithJSON:json];
    GLGroup *knownGroup = [GLGroup new];
    knownGroup.groupId = 1;
    knownGroup.name = @"Foobar Group";
    knownGroup.path = @"foo-bar";
    knownGroup.ownerId = 18;
    
    XCTAssertEqualObjects(testGroup, knownGroup, @"Group did not initialize from json properly");
}

@end
