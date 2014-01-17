//
//  GLUserTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/17/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLUser.h"

static NSString *const kUserLoginResponseString = @"{ \"id\": 1, \"username\": \"john_smith\", \"email\": \"john@example.com\", \"name\": \"John Smith\", \"private_token\": \"dd34asd13as\", \"blocked\": false, \"created_at\": \"2012-05-23T08:00:58Z\", \"bio\": null, \"skype\": \"jsmith\", \"linkedin\": \"jsmith\", \"twitter\": \"jsmithy\", \"dark_scheme\": false, \"theme_id\": 1, \"is_admin\": false, \"can_create_group\" : true, \"can_create_team\" : true, \"can_create_project\" : true }";

@interface GLUserTests : XCTestCase

@end

@implementation GLUserTests

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

- (void)testUserLoginDataJsonInitializer
{
    GLUser *knownUser = [[GLUser alloc] init];
    knownUser.userId = 1;
    knownUser.username = @"john_smith";
    knownUser.email = @"john@example.com";
    knownUser.name = @"John Smith";
    knownUser.skype = @"jsmith";
    knownUser.linkedin = @"jsmith";
    knownUser.twitter = @"jsmithy";
    knownUser.themeId = 1;
    
    NSData *loginData = [kUserLoginResponseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *loginJson = [NSJSONSerialization JSONObjectWithData:loginData options:0 error:nil];
    GLUser *testUser = [[GLUser alloc] initWithJSON:loginJson];
    
    
    XCTAssertEqualObjects(knownUser, testUser, @"User generated from login data not initialized correctly");
}

@end
