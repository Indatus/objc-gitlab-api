//
//  GLProject.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLProject.h"
#import "GLNamespace.h"
#import "GLUser.h"
#import "GLGitlab.h"

NSString * const GLProjectEndpoint = @"/projects";

NSString * const kKeyProjectId = @"id";
NSString * const kKeyDescription = @"description";
NSString * const kKeyDefaultBranch = @"default_branch";
NSString * const kKeyPublicProject = @"public";
NSString * const kKeyVisibilityLevel = @"visibility_level";
NSString * const kKeySshUrl = @"ssh_url_to_repo";
NSString * const kKeyHttpUrl = @"http_url_to_repo";
NSString * const kKeyWebUrl = @"web_url";
NSString * const kKeyOwner = @"owner";
NSString * const kKeyName = @"name";
NSString * const kKeyNameWithNamespace = @"name_with_namespace";
NSString * const kKeyPath = @"path";
NSString * const kKeyPathWithNamespace = @"path_with_namespace";
NSString * const kKeyIssuesEnabled = @"issues_enabled";
NSString * const kKeyMergeRequestsEnabled = @"merge_requests_enabled";
NSString * const kKeyWallEnabled = @"wall_enabled";
NSString * const kKeyWikiEnabled = @"wiki_enabled";
NSString * const kKeySnippetsEnabled = @"snippets_enabled";
NSString * const kKeyCreatedAt = @"created_at";
NSString * const kKeyLastActivityAt = @"last_activity_at";
NSString * const kKeyNamespace = @"namespace";

@implementation GLProject

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        // TODO: all this
        _projectId = [json[kKeyProjectId] longLongValue];
        _description = json[kKeyDescription];
        _defaultBranch = json[kKeyDefaultBranch];
        _publicProject = [json[kKeyPublicProject] boolValue];
        _visibilityLevel = [json[kKeyVisibilityLevel] intValue];
        _sshUrl = json[kKeySshUrl];
        _httpUrl = json[kKeyHttpUrl];
        _webUrl = json[kKeyWebUrl];
        _owner = [[GLUser alloc] initWithJSON:json[kKeyOwner]];
        _name = json[kKeyName];
        _nameWithNamespace = json[kKeyNameWithNamespace];
        _path = json[kKeyPath];
        _pathWithNamespace = json[kKeyPathWithNamespace];
        _issuesEnabled = [json[kKeyIssuesEnabled] boolValue];
        _mergeRequestsEnabled = [json[kKeyMergeRequestsEnabled] boolValue];
        _wallEnabled = [json[kKeyWallEnabled] boolValue];
        _wikiEnabled = [json[kKeyWikiEnabled] boolValue];
        _snippetsEnabled = [json[kKeySnippetsEnabled] boolValue];
        _createdAt = [[[GLGitlab sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyCreatedAt]];
        _lastActivityAt = [[[GLGitlab sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyLastActivityAt]];
        _glNamespace = [[GLNamespace alloc] initWithJSON:json[kKeyNamespace]];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToProject:other];
}

- (BOOL)isEqualToProject:(GLProject *)project {
    if (self == project)
        return YES;
    if (project == nil)
        return NO;
    if (self.projectId != project.projectId)
        return NO;
    if (self.description != project.description && ![self.description isEqualToString:project.description])
        return NO;
    if (self.defaultBranch != project.defaultBranch && ![self.defaultBranch isEqualToString:project.defaultBranch])
        return NO;
    if (self.publicProject != project.publicProject)
        return NO;
    if (self.visibilityLevel != project.visibilityLevel)
        return NO;
    if (self.sshUrl != project.sshUrl && ![self.sshUrl isEqualToString:project.sshUrl])
        return NO;
    if (self.httpUrl != project.httpUrl && ![self.httpUrl isEqualToString:project.httpUrl])
        return NO;
    if (self.webUrl != project.webUrl && ![self.webUrl isEqualToString:project.webUrl])
        return NO;
    if (self.owner != project.owner && ![self.owner isEqualToUser:project.owner])
        return NO;
    if (self.name != project.name && ![self.name isEqualToString:project.name])
        return NO;
    if (self.nameWithNamespace != project.nameWithNamespace && ![self.nameWithNamespace isEqualToString:project.nameWithNamespace])
        return NO;
    if (self.path != project.path && ![self.path isEqualToString:project.path])
        return NO;
    if (self.pathWithNamespace != project.pathWithNamespace && ![self.pathWithNamespace isEqualToString:project.pathWithNamespace])
        return NO;
    if (self.issuesEnabled != project.issuesEnabled)
        return NO;
    if (self.mergeRequestsEnabled != project.mergeRequestsEnabled)
        return NO;
    if (self.wallEnabled != project.wallEnabled)
        return NO;
    if (self.wikiEnabled != project.wikiEnabled)
        return NO;
    if (self.snippetsEnabled != project.snippetsEnabled)
        return NO;
    if (self.createdAt != project.createdAt && ![self.createdAt isEqualToDate:project.createdAt])
        return NO;
    if (self.lastActivityAt != project.lastActivityAt && ![self.lastActivityAt isEqualToDate:project.lastActivityAt])
        return NO;
    if (self.glNamespace != project.glNamespace && ![self.glNamespace isEqualToGlNamespace:project.glNamespace])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.projectId;
    hash = hash * 31u + [self.description hash];
    hash = hash * 31u + [self.defaultBranch hash];
    hash = hash * 31u + self.publicProject;
    hash = hash * 31u + self.visibilityLevel;
    hash = hash * 31u + [self.sshUrl hash];
    hash = hash * 31u + [self.httpUrl hash];
    hash = hash * 31u + [self.webUrl hash];
    hash = hash * 31u + [self.owner hash];
    hash = hash * 31u + [self.name hash];
    hash = hash * 31u + [self.nameWithNamespace hash];
    hash = hash * 31u + [self.path hash];
    hash = hash * 31u + [self.pathWithNamespace hash];
    hash = hash * 31u + self.issuesEnabled;
    hash = hash * 31u + self.mergeRequestsEnabled;
    hash = hash * 31u + self.wallEnabled;
    hash = hash * 31u + self.wikiEnabled;
    hash = hash * 31u + self.snippetsEnabled;
    hash = hash * 31u + [self.createdAt hash];
    hash = hash * 31u + [self.lastActivityAt hash];
    hash = hash * 31u + [self.glNamespace hash];
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.projectId=%qi", self.projectId];
    [description appendFormat:@", self.description=%@", self.description];
    [description appendFormat:@", self.defaultBranch=%@", self.defaultBranch];
    [description appendFormat:@", self.publicProject=%d", self.publicProject];
    [description appendFormat:@", self.visibilityLevel=%i", self.visibilityLevel];
    [description appendFormat:@", self.sshUrl=%@", self.sshUrl];
    [description appendFormat:@", self.httpUrl=%@", self.httpUrl];
    [description appendFormat:@", self.webUrl=%@", self.webUrl];
    [description appendFormat:@", self.owner=%@", self.owner];
    [description appendFormat:@", self.name=%@", self.name];
    [description appendFormat:@", self.nameWithNamespace=%@", self.nameWithNamespace];
    [description appendFormat:@", self.path=%@", self.path];
    [description appendFormat:@", self.pathWithNamespace=%@", self.pathWithNamespace];
    [description appendFormat:@", self.issuesEnabled=%d", self.issuesEnabled];
    [description appendFormat:@", self.mergeRequestsEnabled=%d", self.mergeRequestsEnabled];
    [description appendFormat:@", self.wallEnabled=%d", self.wallEnabled];
    [description appendFormat:@", self.wikiEnabled=%d", self.wikiEnabled];
    [description appendFormat:@", self.snippetsEnabled=%d", self.snippetsEnabled];
    [description appendFormat:@", self.createdAt=%@", self.createdAt];
    [description appendFormat:@", self.lastActivityAt=%@", self.lastActivityAt];
    [description appendFormat:@", self.glNamespace=%@", self.glNamespace];
    [description appendString:@">"];
    return description;
}

@end