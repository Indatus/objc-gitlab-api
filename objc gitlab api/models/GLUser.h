//
//  GLUser.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const GLUserEndpoint;

@interface GLUser : NSObject

// id
@property (nonatomic, assign) int64_t userId;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *skype;
@property (nonatomic, copy) NSString *linkedin;
@property (nonatomic, copy) NSString *twitter;
@property (nonatomic, copy) NSString *provider;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, assign, getter = isBlocked) BOOL blocked;

@end
