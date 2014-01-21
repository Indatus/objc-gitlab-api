//
//  GLGitlabTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/17/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLGitlab.h"

@interface GLGitlabTests : XCTestCase

@end

@implementation GLGitlabTests

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

- (void)testLogin
{
    GLGitlabSuccessBlock success = ^(id responseObject) {
        XCTAssertNotNil(responseObject, @"Request failed");
    };
    
    GLGitlabFailureBlock failure = ^(NSError *error) {
        XCTAssertNil(error, @"Request failed");
    };
    
    [[GLGitlab sharedInstance] loginToHost:@"http://gitlab.indatus.com"
                                  username:@"jtrespalacios@indatus.com"
                                  password:@"cyddzcVv"
                                   success:success
                                   failure:failure];
}

@end
