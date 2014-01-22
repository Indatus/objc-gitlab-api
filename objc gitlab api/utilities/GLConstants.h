//
//  GLConstants.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/21/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - Error Constants
FOUNDATION_EXPORT NSString *const GLGitlabApiBadRequestError;
FOUNDATION_EXPORT NSString *const GLGitlabApiUnauthorizedError;
FOUNDATION_EXPORT NSString *const GLGitlabApiForbiddenError;
FOUNDATION_EXPORT NSString *const GLGitlabApiNotFound;
FOUNDATION_EXPORT NSString *const GLGitLabApiMethodNotAllowedError;
FOUNDATION_EXPORT NSString *const GLGitlabApiConflictError;
FOUNDATION_EXPORT NSString *const GLGitlabApiServerError;
FOUNDATION_EXPORT NSString *const GLGitLabApiTimeoutError;

typedef NS_ENUM(NSInteger, GLResponseCodes) {
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
