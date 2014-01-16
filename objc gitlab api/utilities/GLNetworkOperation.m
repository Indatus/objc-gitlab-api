//
//  GLNetworkOperation.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLNetworkOperation.h"

@interface GLNetworkOperation ()

@property (nonatomic, retain) NSURLConnection *connection;
@property (nonatomic, retain) NSHTTPURLResponse *response;
@property (nonatomic, retain) NSMutableData *responseData;
@property (nonatomic) BOOL isExecuting;
@property (nonatomic) BOOL isConcurrent;
@property (nonatomic) BOOL isFinished;

@end

@implementation GLNetworkOperation

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

- (instancetype)initWithUrl:(NSURL *)url method:(NSString *)method params:(NSDictionary *)params
                    success:(GLNetworkOperationSuccessBlock)success failure:(GLNetworkOperationFailureBlock)failure
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:params
                                                       options:0
                                                         error:nil];
    return [[GLNetworkOperation alloc] initWithRequest:request success:success failure:failure];
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
    NSError *error;
    id responseObject = [NSJSONSerialization JSONObjectWithData:_responseData
                                                        options:NSJSONReadingAllowFragments
                                                          error:&error];
    if (!error && _successBlock) {
        _successBlock(responseObject);
    }
    else if (error && _failureBlock) {
        _failureBlock(error, _response.statusCode, _responseData);
    }
    self.isExecuting = NO;
    self.isFinished = YES;
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
