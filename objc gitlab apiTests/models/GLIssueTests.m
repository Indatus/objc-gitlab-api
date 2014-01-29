//
//  GLIssueTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/29/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface GLIssueTests : XCTestCase

@end

@implementation GLIssueTests

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

- (void)testExample
{
    NSString *testDataPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"issues" ofType:@"json"];
    NSData *testData = [NSData dataWithContentsOfFile:testDataPath];
    NSArray *jsonObject = [NSJSONSerialization JSONObjectWithData:testData
                                                          options:0
                                                            error:nil];
    
    XCTAssertNotNil(jsonObject, @"Json object didn't load");
}

@end
