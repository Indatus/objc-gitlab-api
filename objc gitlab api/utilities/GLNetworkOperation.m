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

@end

@implementation GLNetworkOperation

- (instancetype)initWithRequest:(NSURLRequest *)request
{
    if ((self = [super init])) {
        _connection = [[NSURLConnection alloc] initWithRequest:request
                                                      delegate:self
                                              startImmediately:NO];
    }
    
    return self;
}

- (instancetype)initWithUrl:(NSURL *)url method:(NSString *)method params:(NSDictionary *)params
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = method;
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:params
                                                       options:0
                                                         error:nil];
    return [[GLNetworkOperation alloc] initWithRequest:request];
}

- (void)main
{
    
}

@end
