//
//  GLUser.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLJsonProtocol.h"

@interface GLUser : NSObject <GLJsonProtocol>

// id
@property (nonatomic, assign) int64_t userId;
// username
@property (nonatomic, copy) NSString *username;
// email
@property (nonatomic, copy) NSString *email;
// name
@property (nonatomic, copy) NSString *name;
// skype
@property (nonatomic, copy) NSString *skype;
// linkedin
@property (nonatomic, copy) NSString *linkedin;
// twitter
@property (nonatomic, copy) NSString *twitter;
// provider
@property (nonatomic, copy) NSString *provider;
// state
@property (nonatomic, copy) NSString *state;
// created_at
@property (nonatomic, strong) NSDate *createdAt;
// bio
@property (nonatomic, copy) NSString *bio;
// extern_uid
@property (nonatomic, copy) NSString *externUid;
// theme_id
@property (nonatomic, assign) int32_t themeId;
// color_scheme_id
@property (nonatomic, assign) int32_t colorSchemeId;
// is_admin
@property (nonatomic, getter = isAdmin) BOOL admin;

@end
