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
    
    
    
    
    
}

@end

/*
 // id
 @property (nonatomic, assign) int64_t userId;
 // username
 @property (nonatomic, copy) NSString *username;
 // email
 @property (nonatomic, copy) NSString *email;
 // name
 @property (nonatomic, copy) NSString *name;
 // skype
 @property (nonatomic, copy) NSString *skype;
 // linkedin
 @property (nonatomic, copy) NSString *linkedin;
 // twitter
 @property (nonatomic, copy) NSString *twitter;
 // provider
 @property (nonatomic, copy) NSString *provider;
 // state
 @property (nonatomic, copy) NSString *state;
 // created_at
 @property (nonatomic, strong) NSDate *createdAt;
 // bio
 @property (nonatomic, copy) NSString *bio;
 // extern_uid
 @property (nonatomic, copy) NSString *externUid;
 // theme_id
 @property (nonatomic, assign) int32_t themeId;
 // color_scheme_id
 @property (nonatomic, assign) int32_t colorSchemeId;
 // is_admin
 @property (nonatomic, getter = isAdmin) BOOL admin;
*/