//
//  GLProject.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const GLProjectEndpoint;

@class GLNamespace;

@interface GLProject : NSObject

@property (nonatomic, assign) int64_t projectId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSString *defaultBranch;
@property (nonatomic, assign, getter=isPublicProject) BOOL publicProject;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, copy) NSString *pathWithNamespace;
@property (nonatomic, assign, getter=areIssuesEnabled) BOOL issuesEnabled;
@property (nonatomic, assign, getter=areMergeRequestsEnabled) BOOL mergeRequestsEnabled;
@property (nonatomic, assign, getter=isWallEnabled) BOOL wallEnabled;
@property (nonatomic, assign, getter=isWikiEnabled) BOOL wikiEnabled;
@property (nonatomic, strong) NSDate *createdAt;
// ssh_url_to_repo
@property (nonatomic, copy) NSString *sshUrl;
@property (nonatomic, strong) GLNamespace *namespace;


@end
