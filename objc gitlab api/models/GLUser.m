//
//  GLUser.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLUser.h"
#import "GLGitlabApi.h"

static NSString * const kKeyUserId = @"id";
static NSString * const kKeyUsername = @"username";
static NSString * const kKeyEmail = @"email";
static NSString * const kKeyName = @"name";
static NSString * const kKeySkype = @"skype";
static NSString * const kKeyLinkedin = @"linkedin";
static NSString * const kKeyTwitter = @"twitter";
static NSString * const kKeyProvider = @"provider";
static NSString * const kKeyState = @"state";
static NSString * const kKeyCreatedAt = @"created_at";
static NSString * const kKeyBio = @"bio";
static NSString * const kKeyExternUid = @"extern_uid";
static NSString * const kKeyThemeId = @"theme_id";
static NSString * const kKeyColorSchemeId = @"color_scheme_id";
static NSString * const kKeyAdmin = @"is_admin";

@implementation GLUser

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _userId = [json[kKeyUserId] longLongValue];
        _username = [self checkForNull:json[kKeyUsername]];
        _email = [self checkForNull:json[kKeyEmail]];
        _name = [self checkForNull:json[kKeyName]];
        _skype = [self checkForNull:json[kKeySkype]];
        _linkedin = [self checkForNull:json[kKeyLinkedin]];
        _twitter = [self checkForNull:json[kKeyTwitter]];
        _provider = [self checkForNull:json[kKeyProvider]];
        _state = [self checkForNull:json[kKeyState]];
        _createdAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyCreatedAt]];
        _bio = [self checkForNull:json[kKeyBio]];
        _externUid = [self checkForNull:json[kKeyExternUid]];
        _themeId = [json[kKeyThemeId] intValue];
        _colorSchemeId = [json[kKeyColorSchemeId] intValue];
        _admin = [json[kKeyAdmin] boolValue];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToUser:other];
}

- (BOOL)isEqualToUser:(GLUser *)user {
    if (self == user)
        return YES;
    if (user == nil)
        return NO;
    if (self.userId != user.userId)
        return NO;
    if (self.username != user.username && ![self.username isEqualToString:user.username])
        return NO;
    if (self.email != user.email && ![self.email isEqualToString:user.email])
        return NO;
    if (self.name != user.name && ![self.name isEqualToString:user.name])
        return NO;
    if (self.skype != user.skype && ![self.skype isEqualToString:user.skype])
        return NO;
    if (self.linkedin != user.linkedin && ![self.linkedin isEqualToString:user.linkedin])
        return NO;
    if (self.twitter != user.twitter && ![self.twitter isEqualToString:user.twitter])
        return NO;
    if (self.provider != user.provider && ![self.provider isEqualToString:user.provider])
        return NO;
    if (self.state != user.state && ![self.state isEqualToString:user.state])
        return NO;
    if (self.createdAt != user.createdAt && ![self.createdAt isEqualToDate:user.createdAt])
        return NO;
    if (self.bio != user.bio && ![self.bio isEqualToString:user.bio])
        return NO;
    if (self.externUid != user.externUid && ![self.externUid isEqualToString:user.externUid])
        return NO;
    if (self.themeId != user.themeId)
        return NO;
    if (self.colorSchemeId != user.colorSchemeId)
        return NO;
    if (self.admin != user.admin)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = (NSUInteger) self.userId;
    hash = hash * 31u + [self.username hash];
    hash = hash * 31u + [self.email hash];
    hash = hash * 31u + [self.name hash];
    hash = hash * 31u + [self.skype hash];
    hash = hash * 31u + [self.linkedin hash];
    hash = hash * 31u + [self.twitter hash];
    hash = hash * 31u + [self.provider hash];
    hash = hash * 31u + [self.state hash];
    hash = hash * 31u + [self.createdAt hash];
    hash = hash * 31u + [self.bio hash];
    hash = hash * 31u + [self.externUid hash];
    hash = hash * 31u + self.themeId;
    hash = hash * 31u + self.colorSchemeId;
    hash = hash * 31u + self.admin;
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.userId=%qi", self.userId];
    [description appendFormat:@", self.username=%@", self.username];
    [description appendFormat:@", self.email=%@", self.email];
    [description appendFormat:@", self.name=%@", self.name];
    [description appendFormat:@", self.skype=%@", self.skype];
    [description appendFormat:@", self.linkedin=%@", self.linkedin];
    [description appendFormat:@", self.twitter=%@", self.twitter];
    [description appendFormat:@", self.provider=%@", self.provider];
    [description appendFormat:@", self.state=%@", self.state];
    [description appendFormat:@", self.createdAt=%@", self.createdAt];
    [description appendFormat:@", self.bio=%@", self.bio];
    [description appendFormat:@", self.externUid=%@", self.externUid];
    [description appendFormat:@", self.themeId=%i", self.themeId];
    [description appendFormat:@", self.colorSchemeId=%i", self.colorSchemeId];
    [description appendFormat:@", self.admin=%d", self.admin];
    [description appendString:@">"];
    return description;
}

- (NSDictionary *)jsonRepresentation
{
    NSDateFormatter *formatter = [[GLGitlabApi sharedInstance] gitLabDateFormatter];
    NSNull *null = (id)[NSNull null];
    return @{
             kKeyUserId: @(_userId),
             kKeyUsername: _username,
             kKeyEmail: _email,
             kKeyName: _name ?: null,
             kKeySkype: _skype ?: null,
             kKeyLinkedin: _linkedin ?: null,
             kKeyTwitter: _twitter ?: null,
             kKeyProvider: _provider ?: null,
             kKeyState: _state ?: null,
             kKeyCreatedAt: [formatter stringFromDate:_createdAt] ?: null,
             kKeyBio: _bio ?: null,
             kKeyExternUid: _externUid ?: null,
             kKeyThemeId: @(_themeId),
             kKeyColorSchemeId: @(_colorSchemeId),
             kKeyAdmin: @(_admin)
     };
}

- (NSDictionary *)jsonCreateRepresentation
{
    NSNull *null = [NSNull null];
    return @{
             kKeyUsername: _username,
             kKeyEmail: _email,
             kKeyName: _name ?: null,
             kKeySkype: _skype ?: null,
             kKeyLinkedin: _linkedin ?: null,
             kKeyTwitter: _twitter ?: null,
             kKeyProvider: _provider ?: null,
             kKeyState: _state ?: null,
             kKeyBio: _bio ?: null,
             kKeyAdmin: @(_admin)
             };
}

@end
