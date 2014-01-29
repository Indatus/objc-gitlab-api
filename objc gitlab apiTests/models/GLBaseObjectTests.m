//
//  GLBaseObjectTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/29/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLBaseObject.h"
@interface GLBaseObjectTests : XCTestCase
{
    GLBaseObject *testObject;
}
@end

@implementation GLBaseObjectTests

- (void)setUp
{
    [super setUp];
    testObject = [[GLBaseObject alloc] init];
}

- (void)testNullConversionToNil
{
    XCTAssertNil([testObject checkForNull:[NSNull null]], @"Null value should return nil");
}

- (void)testNonNullValueReturnsvalue
{
    NSString *value = @"Not null";
    XCTAssertEqualObjects([testObject checkForNull:value], value, @"Non null value should return value");
}

@end
