//
//  GLNetworkOperation.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GLNetworkOperationSuccessBlock)(id responseObject);
typedef void (^GLNetworkOperationFailureBlock)(NSError *error, int httpStatus, id response);

@interface GLNetworkOperation : NSObject

@property (nonatomic, copy) GLNetworkOperationSuccessBlock successBlock;
@property (nonatomic, copy) GLNetworkOperationFailureBlock failureBlock;

- (instancetype)initWithRequest:(NSURLRequest *)request;
- (instancetype)initWithUrl:(NSURL *)url method:(NSString *)method params:(NSDictionary *)params;

@end
