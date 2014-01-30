//
//  GLProject.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLBaseObject.h"

@class GLNamespace, GLUser;

@interface GLProject : GLBaseObject

// id
@property (nonatomic, assign) int64_t projectId;
// description
@property (nonatomic, copy) NSString *projectDescription;
// default branch
@property (nonatomic, copy) NSString *defaultBranch;
// public
@property (nonatomic, assign, getter=isPublicProject) BOOL publicProject;
// visibility_level
@property (nonatomic, assign) int32_t visibilityLevel;
// ssh_url_to_repo
@property (nonatomic, copy) NSString *sshUrl;
// http_url_to_repo
@property (nonatomic, copy) NSString *httpUrl;
// web_url
@property (nonatomic, copy) NSString *webUrl;
// owner
@property (nonatomic, strong) GLUser *owner;
// name
@property (nonatomic, copy) NSString *name;
// name_with_namespace
@property (nonatomic, copy) NSString *nameWithNamespace;
// path
@property (nonatomic, copy) NSString *path;
// path_with_namespace
@property (nonatomic, copy) NSString *pathWithNamespace;
// issues_enabled
@property (nonatomic, assign, getter=areIssuesEnabled) BOOL issuesEnabled;
// merge_requests_enabled
@property (nonatomic, assign, getter=areMergeRequestsEnabled) BOOL mergeRequestsEnabled;
// wall_enabled
@property (nonatomic, assign, getter=isWallEnabled) BOOL wallEnabled;
// wiki_enabled
@property (nonatomic, assign, getter=isWikiEnabled) BOOL wikiEnabled;
// snippets_enabled
@property (nonatomic, assign, getter=areSnippetsEnabled) BOOL snippetsEnabled;
// created_at
@property (nonatomic, strong) NSDate *createdAt;
// last_activity_at
@property (nonatomic, strong) NSDate *lastActivityAt;
// namespace
@property (nonatomic, strong) GLNamespace *glNamespace;

- (BOOL)isEqualToProject:(GLProject *)project;

@end
