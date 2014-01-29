//
//  GLRawNetworkOperation.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/29/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLRawNetworkOperation.h"
#import "GLConstants.h"

@implementation GLRawNetworkOperation

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.successBlock && (self.response.statusCode == GLResponseSuccess || self.response.statusCode == GLResponseCreated)) {
        self.successBlock(self.responseData);
    }
    else if (self.failureBlock) {
        NSError *error = [[NSError alloc] initWithDomain:GLNetworkOperationErrorDomain
                                                    code:self.response.statusCode
                                                userInfo:nil];
        self.failureBlock(error, self.response.statusCode, self.responseData);
    }
    
    self.isExecuting = NO;
    self.isFinished = YES;
}

@end
