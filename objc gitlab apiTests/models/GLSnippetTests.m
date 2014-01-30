//
//  GLSnippetTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/30/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLGitlabApi.h"
#import "GLSnippet.h"
#import "GLUser.h"

@interface GLSnippetTests : XCTestCase

@end

@implementation GLSnippetTests

- (void)testSnippetJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSDictionary *snippetJson = [GLTestUtility loadJsonFile:@"snippet"];
    
    GLSnippet *testSnippet = [[GLSnippet alloc] initWithJSON:snippetJson];
    GLSnippet *knownSnippet = [GLSnippet new];
    knownSnippet.snippetId = 1;
    knownSnippet.title = @"test";
    knownSnippet.file_name = @"add.rb";
    knownSnippet.author = [GLUser new];
    knownSnippet.author.userId = 1;
    knownSnippet.author.username = @"john_smith";
    knownSnippet.author.email = @"john@example.com";
    knownSnippet.author.name = @"John Smith";
    knownSnippet.author.state = @"active";
    knownSnippet.author.createdAt = [formatter dateFromString:@"2012-05-23T08:00:58Z"];
    knownSnippet.updatedAt = [formatter dateFromString:@"2012-06-28T10:52:04Z"];
    knownSnippet.createdAt = [formatter dateFromString:@"2012-06-28T10:52:04Z"];
    
    XCTAssertEqualObjects(knownSnippet, testSnippet, @"Snippet initialied from JSON incorrectly");
    
}

@end
