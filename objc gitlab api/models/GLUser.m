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

@end