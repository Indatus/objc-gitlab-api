//
//  GLUser.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLUser.h"
#import "GLGitlabApi.h"

NSString * const GLUserEndpoint = @"/users";

NSString * const kKeyUserId = @"id";
NSString * const kKeyUsername = @"username";
NSString * const kKeyEmail = @"email";
NSString * const kKeyName = @"name";
NSString * const kKeySkype = @"skype";
NSString * const kKeyLinkedin = @"linkedin";
NSString * const kKeyTwitter = @"twitter";
NSString * const kKeyProvider = @"provider";
NSString * const kKeyState = @"state";
NSString * const kKeyCreatedAt = @"created_at";
NSString * const kKeyBio = @"bio";
NSString * const kKeyExternUid = @"extern_uid";
NSString * const kKeyThemeId = @"theme_id";
NSString * const kKeyColorSchemeId = @"color_scheme_id";
NSString * const kKeyAdmin = @"is_admin";

@implementation GLUser

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        id null = (id)[NSNull null];
        _userId = [json[kKeyUserId] longLongValue];
        _username = json[kKeyUsername];
        _email = json[kKeyEmail];
        _name = json[kKeyName];
        _skype = json[kKeySkype] == null ? nil : json[kKeySkype];
        _linkedin = json[kKeyLinkedin] == null ? nil : json[kKeyLinkedin];
        _twitter = json[kKeyTwitter]  == null ? nil : json[kKeyTwitter];
        _provider = json[kKeyProvider] == null ? nil : json[kKeyProvider];
        _state = json[kKeyState] == null ? nil : json[kKeyState];
        _createdAt = [[[GLGitlabApi sharedInstance] gitLabDateFormatter] dateFromString:json[kKeyCreatedAt]];
        _bio = json[kKeyBio] == null ? nil : json[kKeyBio];
        _externUid = json[kKeyExternUid] == null ? nil : json[kKeyExternUid];
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

@end
