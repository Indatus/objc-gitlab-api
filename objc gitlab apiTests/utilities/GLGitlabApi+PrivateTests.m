//
//  GLGitlabApi+PrivateTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 2/3/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLGitlabApi+Private.h"
#import "GLUser.h"

static NSString * const kUsernameKey = @"username";
static NSString * const kUsernameValue = @"testuser";
static NSString * const kPasswordKey = @"password";
static NSString * const kPasswordValue = @"This is a & Password!";

@interface GLGitlabApi_PrivateTests : XCTestCase
@end

@implementation GLGitlabApi_PrivateTests

- (void)testEncodeGetParams
{
    NSString *knownQueryString = @"username=testuser&password=This%20is%20a%20%26%20Password%21";
    
    NSString *testQueryString = [[GLGitlabApi sharedInstance] urlEncodeParamsForGet:
                                 @{kUsernameKey: kUsernameValue,
                                   kPasswordKey: kPasswordValue}];
    
    XCTAssertEqualObjects(testQueryString, knownQueryString, @"URLEncode get params failed");
}

- (void)testEncodeGetParamsWithEndpoint
{
    NSString *knownEndpoint = @"/login?username=testuser&password=This%20is%20a%20%26%20Password%21";
    
    NSString *testEndpoint = [[GLGitlabApi sharedInstance] urlEncodeParamsForGet:@{kUsernameKey: kUsernameValue,
                                                                                   kPasswordKey: kPasswordValue}
                                                                        endpoint:@"/login"];

    XCTAssertEqualObjects(testEndpoint, knownEndpoint, @"URLEncode get params with endpoint failed");
}

- (void)testEncodePostParams
{
    NSData *knownData = [@"username=testuser&password=This%20is%20a%20%26%20Password%21" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *testData = [[GLGitlabApi sharedInstance] urlEncodeParams:
                        @{kUsernameKey: kUsernameValue,
                          kPasswordKey: kPasswordValue}];
    
    XCTAssertEqualObjects(testData, knownData, @"URLEncode non get params failed");
}

- (void)testProcessJsonArrayWithClass
{
    NSArray *testData = [GLTestUtility loadJsonFile:@"multiple_users"];
    NSMutableArray *knownArray = [NSMutableArray arrayWithCapacity:testData.count];
    for (NSDictionary *dict in testData) {
        GLUser *user = [[GLUser alloc] initWithJSON:dict];
        [knownArray addObject:user];
    }
    
    NSArray *testArray = [[GLGitlabApi sharedInstance] processJsonArray:testData
                                                                  class:[GLUser class]];
    
    XCTAssertEqualObjects(knownArray, testArray, @"Parsing of objects using process JSON array failed");
}

@end
