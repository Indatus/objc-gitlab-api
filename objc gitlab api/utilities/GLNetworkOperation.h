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

FOUNDATION_EXPORT NSString *const GLNetworkOperationErrorDomain;

typedef NS_ENUM(NSInteger, GLNetworkOperationType) {
    GLNetworkOperationTypeJson,
    GLNetworkOperationTypeVoid,
    GLNetworkOperationTypeRaw
};

typedef void (^GLNetworkOperationSuccessBlock)(id responseObject);
typedef void (^GLNetworkOperationFailureBlock)(NSError *error, NSInteger httpStatus, NSData *responseData);

@interface GLNetworkOperation : NSOperation <NSURLConnectionDataDelegate, NSURLConnectionDelegate>

@property (nonatomic, copy, readonly) GLNetworkOperationSuccessBlock successBlock;
@property (nonatomic, copy, readonly) GLNetworkOperationFailureBlock failureBlock;
@property (nonatomic, strong, readonly) NSURLConnection *connection;
@property (nonatomic, strong, readonly) NSHTTPURLResponse *response;
@property (nonatomic, strong, readonly) NSMutableData *responseData;

@property (nonatomic) BOOL isExecuting;
@property (nonatomic) BOOL isConcurrent;
@property (nonatomic) BOOL isFinished;

+ (GLNetworkOperation *)operationOfType:(GLNetworkOperationType)type
                                request:(NSURLRequest *)request
                                success:(GLNetworkOperationSuccessBlock)success
                                failure:(GLNetworkOperationFailureBlock)failure;

@end
