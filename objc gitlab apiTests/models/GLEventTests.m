//
//  GLEventTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/29/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLEvent.h"

static NSString *const kEventsJson = @"[{ \"title\": null, \"project_id\": 15, \"action_name\": \"closed\", \"target_id\": 830, \"target_type\": \"Issue\", \"author_id\": 1, \"data\": null, \"target_title\": \"Public project search field\" }, { \"title\": null, \"project_id\": 15, \"action_name\": \"opened\", \"target_id\": null, \"target_type\": null, \"author_id\": 1, \"data\": { \"before\": \"50d4420237a9de7be1304607147aec22e4a14af7\", \"after\": \"c5feabde2d8cd023215af4d2ceeb7a64839fc428\",\"ref\": \"refs/heads/master\", \"user_id\": 1, \"user_name\": \"Dmitriy Zaporozhets\",   \"repository\": { \"name\": \"gitlabhq\", \"url\": \"git@dev.gitlab.org:gitlab/gitlabhq.git\", \"description\": \"GitLab: self hosted Git management software. Distributed under the MIT License.\", \"homepage\": \"https://dev.gitlab.org/gitlab/gitlabhq\" }, \"commits\": [{ \"id\": \"c5feabde2d8cd023215af4d2ceeb7a64839fc428\", \"message\": \"Add simple search to projects in public area\", \"timestamp\": \"2013-05-13T18:18:08+00:00\", \"url\": \"https://dev.gitlab.org/gitlab/gitlabhq/commit/c5feabde2d8cd023215af4d2ceeb7a64839fc428\", \"author\": { \"name\": \"Dmitriy Zaporozhets\", \"email\": \"dmitriy.zaporozhets@gmail.com\" } }], \"total_commits_count\": 1 }, \"target_title\": null}, { \"title\": null, \"project_id\": 15, \"action_name\": \"closed\", \"target_id\": 840, \"target_type\": \"Issue\", \"author_id\": 1, \"data\": null, \"target_title\": \"Finish & merge Code search PR\"}]";

@interface GLEventTests : XCTestCase

@end

@implementation GLEventTests

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

- (void)testInitWithJson
{
    NSData *jsonData = [kEventsJson dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData
                                                         options:0
                                                           error:nil];
    
    NSMutableArray *testObjects = [NSMutableArray arrayWithCapacity:jsonArray.count];
    for (NSDictionary *dict in jsonArray) {
        [testObjects addObject:[[GLEvent alloc] initWithJSON:dict]];
    }
    
    GLEvent *knownEventOne = [GLEvent new];
    knownEventOne.projectId = 15;
    knownEventOne.actionName = @"closed";
    knownEventOne.targetId = 830;
    knownEventOne.targetType = @"Issue";
    knownEventOne.authorId = 1;
    knownEventOne.targetTitle = @"Public project search field";
    
    GLEvent *knownEventTwo = [GLEvent new];
    knownEventTwo.projectId = 15;
    knownEventTwo.actionName = @"opened";
    knownEventTwo.authorId = 1;
    knownEventTwo.data = @{
                           @"before": @"50d4420237a9de7be1304607147aec22e4a14af7",
                           @"after": @"c5feabde2d8cd023215af4d2ceeb7a64839fc428",
                           @"ref": @"refs/heads/master",
                           @"user_id": @1,
                           @"user_name": @"Dmitriy Zaporozhets",
                           @"repository": @{
                                   @"name": @"gitlabhq",
                                   @"url": @"git@dev.gitlab.org:gitlab/gitlabhq.git",
                                   @"description": @"GitLab: self hosted Git management software. Distributed under the MIT License.",
                                   @"homepage": @"https://dev.gitlab.org/gitlab/gitlabhq"
                                   },
                           @"commits": @[@{
                               @"id": @"c5feabde2d8cd023215af4d2ceeb7a64839fc428",
                               @"message": @"Add simple search to projects in public area",
                               @"timestamp": @"2013-05-13T18:18:08+00:00",
                               @"url": @"https://dev.gitlab.org/gitlab/gitlabhq/commit/c5feabde2d8cd023215af4d2ceeb7a64839fc428",
                               @"author": @{
                                   @"name": @"Dmitriy Zaporozhets",
                                   @"email": @"dmitriy.zaporozhets@gmail.com"
                               }
                           }],
                           @"total_commits_count": @1
                           };
    
    GLEvent *knownEventThree = [GLEvent new];
    knownEventThree.projectId = 15;
    knownEventThree.actionName = @"closed";
    knownEventThree.targetId = 840;
    knownEventThree.targetType = @"Issue",
    knownEventThree.authorId = 1;
    knownEventThree.targetTitle = @"Finish & merge Code search PR";
    
    XCTAssertEqualObjects(testObjects[0], knownEventOne, @"Failed parsing first event");
    XCTAssertEqualObjects(testObjects[1], knownEventTwo, @"Failed parsing second event");
    XCTAssertEqualObjects(testObjects[2], knownEventThree, @"Failed parsing third event");
}

@end
