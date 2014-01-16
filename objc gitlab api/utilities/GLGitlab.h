//
//  GLGitlab.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLGitlab : NSObject

+ (GLGitlab *)sharedInstance;

@end

NS_ENUM(int16_t, GLResponseCodes) {
    Success = 200,
    Created = 201,
    BadRequest = 400,
    Unauthorized = 401,
    Forbidden = 403,
    NotFound = 404,
    MethodNotAllowed = 405,
    Conflict = 409,
    ServerError = 500,
    Timeout = 666
};