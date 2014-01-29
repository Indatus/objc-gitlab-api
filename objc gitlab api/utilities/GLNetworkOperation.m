//
//  GLNetworkOperation.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLNetworkOperation.h"
#import "GLJsonNetworkOperation.h"
#import "GLRawNetworkOperation.h"
#import "GLVoidNetworkOperation.h"
#import "GLConstants.h"

NSString *const GLNetworkOperationPostMethod = @"post";
NSString *const GLNetworkOperationGetMethod = @"get";
NSString *const GLNetworkOperationPutMethod = @"put";
NSString *const GLNetworkOperationDeleteMethod = @"delete";

NSString *const GLNetworkOperationErrorDomain = @"com.indatus.GLNetworkOperationErrorDomain";

@interface GLNetworkOperation ()

@property (nonatomic, copy, readwrite) GLNetworkOperationSuccessBlock successBlock;
@property (nonatomic, copy, readwrite) GLNetworkOperationFailureBlock failureBlock;
@property (nonatomic, strong, readwrite) NSURLConnection *connection;
@property (nonatomic, strong, readwrite) NSHTTPURLResponse *response;
@property (nonatomic, strong, readwrite) NSMutableData *responseData;

@end

@implementation GLNetworkOperation

+ (GLNetworkOperation *)operationOfType:(GLNetworkOperationType)type
                                request:(NSURLRequest *)request
                                success:(GLNetworkOperationSuccessBlock)success
                                failure:(GLNetworkOperationFailureBlock)failure;
{
    GLNetworkOperation *op;
    switch (type) {
        case GLNetworkOperationTypeJson:
            op = [[GLJsonNetworkOperation alloc] initWithRequest:request
                                                         success:success
                                                         failure:failure];
            break;
        case GLNetworkOperationTypeRaw:
            op = [[GLRawNetworkOperation alloc] initWithRequest:request
                                                        success:success
                                                        failure:failure];
            break;
        case GLNetworkOperationTypeVoid:
            op = [[GLVoidNetworkOperation alloc] initWithRequest:request
                                                         success:success
                                                         failure:failure];
            break;

    }
    
    return op;
}


- (instancetype)initWithRequest:(NSURLRequest *)request success:(GLNetworkOperationSuccessBlock)success failure:(GLNetworkOperationFailureBlock)failure
{
    if ((self = [super init])) {
        _connection = [[NSURLConnection alloc] initWithRequest:request
                                                      delegate:self
                                              startImmediately:NO];
        _successBlock = [success copy];
        _failureBlock = [failure copy];
    }
    
    return self;
}

- (void)start
{
    self.isExecuting = YES;
    self.isConcurrent = YES;
    self.isFinished = NO;
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [_connection start];
    }];
}

#pragma mark NSURLConnectionDelegate

- (NSURLRequest *)connection:(NSURLConnection *)connection willSendRequest:(NSURLRequest *)request redirectResponse:(NSURLResponse *)response {
    return request;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSHTTPURLResponse *)response {
    self.response = response;
    self.responseData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}


- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse {
    return cachedResponse;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSAssert(false, @"Connection finished loading should be handled in subclass");
}

- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
    self.isExecuting = NO;
    self.isFinished = YES;
}

- (void)setIsExecuting:(BOOL)isExecuting
{
    [self willChangeValueForKey:@"isExecuting"];
    _isExecuting = isExecuting;
    [self didChangeValueForKey:@"isExecuting"];
}


- (void)setIsFinished:(BOOL)isFinished
{
    [self willChangeValueForKey:@"isFinished"];
    _isFinished = isFinished;
    [self didChangeValueForKey:@"isFinished"];
}

- (void)cancel
{
    [super cancel];
    [self.connection cancel];
    self.isFinished = YES;
    self.isExecuting = NO;
}


@end
