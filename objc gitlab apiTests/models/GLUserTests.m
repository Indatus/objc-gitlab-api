//
//  GLUserTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/17/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLGitlabApi.h"
#import "GLUser.h"

@interface GLUserTests : XCTestCase

@end

@implementation GLUserTests

- (void)testUserLoginDataJsonInitializer
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSDictionary *loginJson = [GLTestUtility loadJsonFile:@"user"];
    
    GLUser *testUser = [[GLUser alloc] initWithJSON:loginJson];
    GLUser *knownUser = [[GLUser alloc] init];
    knownUser.userId = 1;
    knownUser.username = @"john_smith";
    knownUser.email = @"john@example.com";
    knownUser.name = @"John Smith";
    knownUser.skype = @"jsmith";
    knownUser.linkedin = @"jsmith";
    knownUser.twitter = @"jsmithy";
    knownUser.themeId = 1;
    knownUser.createdAt = [formatter dateFromString:@"2012-05-23T08:00:58Z"];
    
    XCTAssertEqualObjects(knownUser, testUser, @"User initialized from JSON incorrectly");
}

@end
