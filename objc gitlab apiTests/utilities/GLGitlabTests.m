//
//  GLGitlabTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/17/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "GLGitlab.h"
#import "GLGitlab_Testing.h"

@interface GLGitlabTests : XCTestCase

@end

@implementation GLGitlabTests

- (void)setUp
{
    [super setUp];
    [[[GLGitlabApi sharedInstance] queue] setSuspended:YES];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

//- (void)testLogin
//{
//    __block BOOL done = NO;
//    GLGitlabSuccessBlock success = ^(id responseObject) {
//        XCTAssertNotNil(responseObject, @"Request failed");
//        done = YES;
//    };
//    
//    GLGitlabFailureBlock failure = ^(NSError *error) {
//        XCTAssertNil(error, @"Request failed");
//        done = YES;
//    };
//    GLNetworkOperation *op = [[GLGitlabApi sharedInstance] loginToHost:@"http://gitlab.example.com"
//                                                              username:@"testuser"
//                                                              password:@"password"
//                                                               success:success
//                                                               failure:failure];
//    [[GLGitlabApi sharedInstance] privateToken];
//
//    while (!done) {
//        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
//    }
//}

@end
