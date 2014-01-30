//
//  GLDiffTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/28/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLTestUtility.h"
#import "GLDiff.h"

@interface GLDiffTests : XCTestCase

@end

@implementation GLDiffTests

- (void)testDiffJsonInit
{
    NSDictionary *jsonDict = [GLTestUtility loadJsonFile:@"diff"];
    GLDiff *knownDiff = [[GLDiff alloc] init];
    knownDiff.diff = @"--- a/doc/update/5.4-to-6.0.html\n+++ b/doc/update/5.4-to-6.0.html\n@@ -71,6 +71,8 @@\nsudo -u git -H bundle exec rake migrate_keys RAILS_ENV=production\nsudo -u git -H bundle exec rake \nmigrate_inline_notes RAILS_ENV=production\n\n+sudo -u git -H bundle exec rake assets:precompile RAILS_ENV=production\n+\n```\n\n### 6. Update config files";
    knownDiff.updatedPath = @"doc/update/5.4-to-6.0.html";
    knownDiff.oldPath = @"doc/update/5.4-to-6.0.html";
    knownDiff.aMode = nil;
    knownDiff.bMode = @"100644";
    knownDiff.newFile = NO;
    knownDiff.renamedFile = NO;
    knownDiff.deletedFile = NO;
    
    GLDiff *testDiff = [[GLDiff alloc] initWithJSON:jsonDict];
    
    XCTAssertEqualObjects(knownDiff, testDiff, @"Diff initialized from JSON incorrectly");
    
}

@end
