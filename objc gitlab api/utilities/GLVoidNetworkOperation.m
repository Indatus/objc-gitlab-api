//
//  GLVoidNetworkOperation.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/29/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLVoidNetworkOperation.h"
#import "GLConstants.h"

@implementation GLVoidNetworkOperation

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (self.successBlock && (self.response.statusCode == GLResponseSuccess || self.response.statusCode == GLResponseCreated)) {
        self.successBlock(nil);
    }
    else if (self.failureBlock) {
        NSDictionary *userInfo;
        
        if (self.responseData) {
            NSError *error;
            id object = [NSJSONSerialization JSONObjectWithData:self.responseData
                                                        options:0
                                                          error:&error];
            
            if (!error && [object isKindOfClass:[NSDictionary class]]) {
                userInfo = object;
            }
            else {
                NSLog(@"Error processing response data in void request: %@\n%@", error.localizedDescription, error.userInfo);
            }
        }
        
        NSError *error = [[NSError alloc] initWithDomain:GLNetworkOperationErrorDomain
                                                    code:self.response.statusCode
                                                userInfo:userInfo];
        self.failureBlock(error, self.response.statusCode, self.responseData);
    }
    
    self.isExecuting = NO;
    self.isFinished = YES;
}
@end
