//
//  GLCommitTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/28/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLGitlabApi.h"
#import "GLCommit.h"

@interface GLCommitTests : XCTestCase

@end

@implementation GLCommitTests

- (void)testCommitJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSArray *array = [GLTestUtility loadJsonFile:@"commit"];
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:array.count];
    GLCommit *knownCommit1 = [[GLCommit alloc] init];
    knownCommit1.sha = @"ed899a2f4b50b4370feeea94676502b42383c746";
    knownCommit1.title = @"Replace sanitize with escape once";
    knownCommit1.shortId = @"ed899a2f4b5";
    knownCommit1.authorName = @"Dmitriy Zaporozhets";
    knownCommit1.authorEmail = @"dzaporozhets@sphereconsultinginc.com";
    knownCommit1.createdAt = [formatter dateFromString:@"2012-09-20T11:50:22+03:00"];
    
    GLCommit *knownCommit2 = [[GLCommit alloc] init];
    knownCommit2.sha = @"6104942438c14ec7bd21c6cd5bd995272b3faff6";
    knownCommit2.title = @"Sanitize for network graph";
    knownCommit2.shortId = @"6104942438c";
    knownCommit2.authorName = @"randx";
    knownCommit2.authorEmail = @"dmitriy.zaporozhets@gmail.com";
    knownCommit2.createdAt = [formatter dateFromString:@"2012-09-20T09:06:12+03:00"];
    
    NSArray *knownObjects = @[knownCommit1, knownCommit2];
    
    for (NSDictionary *dictionary in array) {
        GLCommit *commit = [[GLCommit alloc] initWithJSON:dictionary];
        [results addObject:commit];
    }
    
    XCTAssertEqualObjects(knownObjects, [results copy], @"Commit initialized from JSON incorrectly");
}

@end
