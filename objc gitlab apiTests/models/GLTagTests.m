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
#import "GLUser.h"
#import "GLCommit.h"

@interface GLTagTests : XCTestCase

@end

@implementation GLTagTests

- (void)testTagJsonInit
{
    NSDictionary *tagJson = [GLTestUtility loadJsonFile:@"tag"];
    GLTag *testTag = [[GLTag alloc] initWithJSON:tagJson];
    GLTag *knownTag = [GLTag new];
    
    XCTAssertEqualObjects(knownTag, testTag, @"Tag initialized from JSON incorrectly");
}

@end
