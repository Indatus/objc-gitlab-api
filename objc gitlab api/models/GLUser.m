//
//  GLUser.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLUser.h"

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
NSString * const kKeyCreatedAd = @"created_at";
NSString * const kKeyBio = @"bio";
NSString * const kKeyExternUid = @"extern_uid";
NSString * const kKeyThemeId = @"theme_id";
NSString * const kKeyColorSchemeId = @"color_scheme_id";
NSString * const kKeyAdmin = @"is_admin";

@implementation GLUser

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _userId = [json[kKeyUserId] longLongValue];
        _username = json[kKeyUsername];
        _email = json[kKeyEmail];
        _name = json[kKeyName];
        _skype = json[kKeySkype];
        _linkedin = json[kKeyLinkedin];
        _twitter = json[kKeyTwitter];
        _provider = json[kKeyProvider];
        _state = json[kKeyState];
        // TODO: date
        _bio = json[kKeyBio];
        _externUid = json[kKeyExternUid];
        _themeId = [json[kKeyThemeId] intValue];
        _colorSchemeId = [json[kKeyColorSchemeId] intValue];
        _admin = [json[kKeyAdmin] boolValue];
    }
    return self;
}

- (BOOL)isEqual:(id)object
{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    return [self isEqualToUser:object];
}

- (BOOL)isEqualToUser:(GLUser *)other
{
    if (_userId != other.userId) {
        return NO;
    }
    
    if (![_username isEqualToString:other.username]) {
        return NO;
    }
    
    if (![_email isEqualToString:other.email]) {
        return NO;
    }
    
    if (![_name isEqualToString:other.name]) {
        return NO;
    }
    
    if (![_skype isEqualToString:other.skype]) {
        return NO;
    }
    
    if (![_linkedin isEqualToString:other.linkedin]) {
        return NO;
    }
    
    if (![_twitter isEqualToString:other.twitter]) {
        return NO;
    }
    
    if (![_provider isEqualToString:other.provider]) {
        return NO;
    }
    
    if (![_state isEqualToString:other.state]) {
        return NO;
    }
    
    if (![_createdAt isEqualToDate:other.createdAt]) {
        return NO;
    }
    
    if (![_bio isEqualToString:other.bio]) {
        return NO;
    }

    if (![_externUid isEqualToString:other.externUid]) {
        return NO;
    }
    
    if (_themeId != other.themeId) {
        return NO;
    }
    
    if (_colorSchemeId != other.colorSchemeId) {
        return NO;
    }
    
    if (_admin != other.isAdmin) {
        return NO;
    }
    
    return YES;
}

- (NSUInteger)hash
{
    NSUInteger usernameHash = [_username hash];
    NSUInteger emailHash = [_email hash];
    NSUInteger userIdHash = _userId;
    
    return usernameHash ^ emailHash ^ userIdHash;
}

@end