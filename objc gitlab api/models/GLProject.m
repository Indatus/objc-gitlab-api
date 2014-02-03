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
#import "GLGitlabApi.h"

static NSString * const kKeyProjectId = @"id";
static NSString * const kKeyDescription = @"description";
static NSString * const kKeyDefaultBranch = @"default_branch";
static NSString * const kKeyPublicProject = @"public";
static NSString * const kKeyVisibilityLevel = @"visibility_level";
static NSString * const kKeySshUrl = @"ssh_url_to_repo";
static NSString * const kKeyHttpUrl = @"http_url_to_repo";
static NSString * const kKeyWebUrl = @"web_url";
static NSString * const kKeyOwner = @"owner";
static NSString * const kKeyName = @"name";
static NSString * const kKeyNameWithNamespace = @"name_with_namespace";
static NSString * const kKeyPath = @"path";
static NSString * const kKeyPathWithNamespace = @"path_with_namespace";
static NSString * const kKeyIssuesEnabled = @"issues_enabled";
static NSString * const kKeyMergeRequestsEnabled = @"merge_requests_enabled";
static NSString * const kKeyWallEnabled = @"wall_enabled";
static NSString * const kKeyWikiEnabled = @"wiki_enabled";
static NSString * const kKeySnippetsEnabled = @"snippets_enabled";
static NSString * const kKeyCreatedAt = @"created_at";
static NSString * const kKeyLastActivityAt = @"last_activity_at";
static NSString * const kKeyNamespace = @"namespace";

@implementation GLProject

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _projectId = [json[kKeyProjectId] longLongValue];
        _projectDescription = [self checkForNull:json[kKeyDescription]];
        _defaultBranch = [self checkForNull:json[kKeyDefaultBranch]];
        _publicProject = [json[kKeyPublicProject] boolValue];
        _visibilityLevel = [json[kKeyVisibilityLevel] intValue];
        _sshUrl = [self checkForNull:json[kKeySshUrl]];
        _httpUrl = [self checkForNull:json[kKeyHttpUrl]];
        _webUrl = [self checkForNull:json[kKeyWebUrl]];
        _owner = [[GLUser alloc] initWithJSON:json[kKeyOwner]];
        _name = [self checkForNull:json[kKeyName]];
        _nameWithNamespace = [self checkForNull:json[kKeyNameWithNamespace]];
        _path = [self checkForNull:json[kKeyPath]];
        _pathWithNamespace = [self checkForNull:json[kKeyPathWithNamespace]];
        _issuesEnabled = [json[kKeyIssuesEnabled] boolValue];
        _mergeRequestsEnabled = [json[kKeyMergeRequestsEnabled] boolValue];
        _wallEnabled = [json[kKeyWallEnabled] boolValue];
        _wikiEnabled = [json[kKeyWikiEnabled] boolValue];
        _snippetsEnabled = [json[kKeySnippetsEnabled] boolValue];
        _createdAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyCreatedAt]];
        _lastActivityAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyLastActivityAt]];
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
    if (self.projectDescription != project.projectDescription && ![self.projectDescription isEqualToString:project.projectDescription])
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
    hash = hash * 31u + [self.projectDescription hash];
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
    [description appendFormat:@", self.projectDescription=%@", self.projectDescription];
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

- (NSDictionary *)jsonRepresentation
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSNull *null = [NSNull null];
    
    return @{
             kKeyProjectId: @(_projectId),
             kKeyDescription: _projectDescription ?: null,
             kKeyDefaultBranch: _defaultBranch ?: null,
             kKeyPublicProject: @(_publicProject),
             kKeyVisibilityLevel: @(_visibilityLevel),
             kKeySshUrl: _sshUrl ?: null,
             kKeyHttpUrl: _httpUrl ?: null,
             kKeyWebUrl: _webUrl ?: null,
             kKeyOwner: [_owner jsonRepresentation],
             kKeyName: _name ?: null,
             kKeyNameWithNamespace: _nameWithNamespace ?: null,
             kKeyPath: _path ?: null,
             kKeyPathWithNamespace: _pathWithNamespace ?: null,
             kKeyIssuesEnabled: @(_issuesEnabled),
             kKeyMergeRequestsEnabled: @(_mergeRequestsEnabled),
             kKeyWallEnabled: @(_wallEnabled),
             kKeyWikiEnabled: @(_wikiEnabled),
             kKeySnippetsEnabled: @(_snippetsEnabled),
             kKeyCreatedAt: [formatter stringFromDate:_createdAt],
             kKeyLastActivityAt: [formatter stringFromDate:_lastActivityAt],
             kKeyNamespace: [_glNamespace jsonRepresentation]
             };
}

- (NSDictionary *)jsonCreateRepresentation
{
    NSNull *null = [NSNull null];
    
    return @{
             kKeyName: _name,
             kKeyDescription: _projectDescription ?: null,
             kKeyIssuesEnabled: @(_issuesEnabled),
             kKeyWallEnabled: @(_wallEnabled),
             kKeyMergeRequestsEnabled: @(_mergeRequestsEnabled),
             kKeyWikiEnabled: @(_wikiEnabled),
             kKeySnippetsEnabled: @(_snippetsEnabled),
             kKeyPublicProject: @(_publicProject)
             };
}

@end
