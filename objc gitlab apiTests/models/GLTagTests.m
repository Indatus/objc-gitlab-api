//
//  GLTagTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/30/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLGitlabApi.h"
#import "GLTag.h"
#import "GLCommit.h"

@interface GLTagTests : XCTestCase

@end

@implementation GLTagTests

- (void)testTagJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSDictionary *tagJson = [GLTestUtility loadJsonFile:@"tag"];
    GLTag *testTag = [[GLTag alloc] initWithJSON:tagJson];
    GLTag *knownTag = [GLTag new];
    knownTag.name = @"v1.0.0";
    knownTag.protectedTag = NO;
    knownTag.commit = [GLCommit new];
    knownTag.commit.sha = @"2695effb5807a22ff3d138d593fd856244e155e7";
    knownTag.commit.shortId = @"2695effb580";
    knownTag.commit.title = @"Initial commit";
    knownTag.commit.authorEmail = @"john@example.com";
    knownTag.commit.authorName = @"John Smith";
    knownTag.commit.createdAt = [formatter dateFromString:@"2012-05-28T04:42:42-07:00"];
    
    
    XCTAssertEqualObjects(knownTag, testTag, @"Tag initialized from JSON incorrectly");
}

@end
