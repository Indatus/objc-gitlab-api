//
//  GLDiffTests.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/28/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "GLDiff.h"

static NSString * const diffJson = @"{ \"diff\": \"--- a/doc/update/5.4-to-6.0.html\
+++ b/doc/update/5.4-to-6.0.html\
@@ -71,6 +71,8 @@\
sudo -u git -H bundle exec rake migrate_keys RAILS_ENV=production\
sudo -u git -H bundle exec rake migrate_inline_notes RAILS_ENV=production\
\
+sudo -u git -H bundle exec rake assets:precompile RAILS_ENV=production\
+\
```\
\
### 6. Update config files\",    \"new_path\": \"doc/update/5.4-to-6.0.html\", \"old_path\": \"doc/update/5.4-to-6.0.html\", \"a_mode\": null, \"b_mode\": \"100644\", \"new_file\": false, \"renamed_file\": false, \"deleted_file\": false }";

@interface GLDiffTests : XCTestCase

@end

@implementation GLDiffTests

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

- (void)testJsonInit
{
    NSError *error;
    NSData *jsonData = [diffJson dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData
                                                             options:0
                                                               error:&error];
    if (error) {
        NSLog(@"Error parsing json: %@", error);
    }
    GLDiff *knownDiff = [[GLDiff alloc] init];
    knownDiff.diff = @"--- a/doc/update/5.4-to-6.0.html\
+++ b/doc/update/5.4-to-6.0.html\
@@ -71,6 +71,8 @@\
sudo -u git -H bundle exec rake migrate_keys RAILS_ENV=production\
sudo -u git -H bundle exec rake migrate_inline_notes RAILS_ENV=production\
\
+sudo -u git -H bundle exec rake assets:precompile RAILS_ENV=production\
+\
```\
\
### 6. Update config files";
    knownDiff.updatedPath = @"doc/update/5.4-to-6.0.html";
    knownDiff.oldPath = @"doc/update/5.4-to-6.0.html";
    knownDiff.aMode = nil;
    knownDiff.bMode = @"100644";
    knownDiff.newFile = NO;
    knownDiff.renamedFile = NO;
    knownDiff.deletedFile = NO;
    
    GLDiff *testDiff = [[GLDiff alloc] initWithJSON:jsonDict];
    
    XCTAssertEqualObjects(knownDiff, testDiff, @"Diff parsed from JSON incorrectly");
    
}

@end
