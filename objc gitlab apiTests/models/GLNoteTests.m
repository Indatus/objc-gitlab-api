//
//  GLNoteTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/30/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLGitlabApi.h"
#import "GLUser.h"
#import "GLNote.h"

@interface GLNoteTests : XCTestCase

@end

@implementation GLNoteTests

- (void)testNoteJsonInit
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSDictionary *noteJson = [GLTestUtility loadJsonFile:@"note"];
    
    GLNote *testNote = [[GLNote alloc] initWithJSON:noteJson];
    GLNote *knownNote = [GLNote new];
    knownNote.noteId = 522;
    knownNote.body = @"The solution is rather tricky";
    knownNote.createdAt = [formatter dateFromString:@"2012-11-27T19:16:44Z"];
    knownNote.author = [GLUser new];
    knownNote.author.userId = 1;
    knownNote.author.username = @"john_smith";
    knownNote.author.email = @"john@example.com";
    knownNote.author.name = @"John Smith";
    knownNote.author.state = @"active";
    knownNote.author.createdAt = [formatter dateFromString:@"2012-05-23T08:00:58Z"];
    
    
    XCTAssertEqualObjects(knownNote, testNote, @"Note initalization with json failed");
}

@end
