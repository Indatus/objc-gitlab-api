//
//  GLNetworkOperation.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT NSString *const GLNetworkOperationPostMethod;
FOUNDATION_EXPORT NSString *const GLNetworkOperationGetMethod;
FOUNDATION_EXPORT NSString *const GLNetworkOperationPutMethod;
FOUNDATION_EXPORT NSString *const GLNetworkOperationDeleteMethod;

FOUNDATION_EXPORT NSString *const GLNetworkOperationErrorDomain;;

typedef void (^GLNetworkOperationSuccessBlock)(id responseObject);
typedef void (^GLNetworkOperationFailureBlock)(NSError *error, NSInteger httpStatus, NSData *responseData);

@interface GLNetworkOperation : NSOperation <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

- (instancetype)initWithRequest:(NSURLRequest *)request
                        success:(GLNetworkOperationSuccessBlock)success
                        failure:(GLNetworkOperationFailureBlock)failure;

- (instancetype)initWithUrl:(NSURL *)url
                     method:(NSString *)method
                     params:(NSDictionary *)params
                    success:(GLNetworkOperationSuccessBlock)success
                    failure:(GLNetworkOperationFailureBlock)failure;

@end
