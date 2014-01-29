//
//  GLJsonNetworkOperation.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/29/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLJsonNetworkOperation.h"
#import "GLConstants.h"

@implementation GLJsonNetworkOperation

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error;
    id responseObject = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                        options:NSJSONReadingAllowFragments
                                                          error:&error];
    if (!error && self.successBlock && (self.response.statusCode == GLResponseSuccess || self.response.statusCode == GLResponseCreated)) {
        self.successBlock(responseObject);
    }
    else if (self.failureBlock) {
        if (error) {
            self.failureBlock(error, self.response.statusCode, self.responseData);
        }
        else {
            NSError *error = [[NSError alloc] initWithDomain:GLNetworkOperationErrorDomain
                                                        code:self.response.statusCode
                                                    userInfo:responseObject];
            self.failureBlock(error, self.response.statusCode, self.responseData);
        }
    }
    
    self.isExecuting = NO;
    self.isFinished = YES;
}

@end
