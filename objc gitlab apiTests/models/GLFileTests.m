//
//  GLFileTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLFile.h"

@interface GLFileTests : XCTestCase

@end

@implementation GLFileTests

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

- (void)testJsonInitTreeFile
{
    NSDictionary *json = [GLTestUtility loadJsonFile:@"tree_file"];
    GLFile *testFile = [[GLFile alloc] initWithJSON:json];
    GLFile *knownFile = [GLFile new];
    knownFile.name = @"assets";
    knownFile.type = GLFileTypeTree;
    knownFile.mode = @"040000";
    knownFile.fileId = @"6229c43a7e16fcc7e95f923f8ddadb8281d9c6c6";
    
    
    XCTAssertEqualObjects(knownFile, testFile, @"Tree file failed to initialize");
}

- (void)testJsonInitBlobFile
{
    NSDictionary *json = [GLTestUtility loadJsonFile:@"blob_file"];
    GLFile *testFile = [[GLFile alloc] initWithJSON:json];
    GLFile *knownFile = [GLFile new];
    knownFile.name = @"Rakefile";
    knownFile.type = GLFileTypeBlob;
    knownFile.mode = @"100644";
    knownFile.fileId = @"35b2f05cbb4566b71b34554cf184a9d0bd9d46d6";
    
    
    XCTAssertEqualObjects(knownFile, testFile, @"Tree file failed to initialize");
}

@end
