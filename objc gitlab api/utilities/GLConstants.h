//
//  GLConstants.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/21/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ENUM(int16_t, GLResponseCodes) {
    GLResponseSuccess = 200,
    GLResponseCreated = 201,
    GLResponseBadRequest = 400,
    GLResponseUnauthorized = 401,
    GLResponseForbidden = 403,
    GLResponseNotFound = 404,
    GLResponseMethodNotAllowed = 405,
    GLResponseConflict = 409,
    GLResponseServerError = 500,
    GLResponseTimeout = 666
};
