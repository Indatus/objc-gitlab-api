//
//  GLGitlab.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GLGitlabSuccessBlock)(id responseObject);
typedef void (^GLGitlabFailureBlock)(NSError *error);

@interface GLGitlab : NSObject

+ (GLGitlab *)sharedInstance;

- (NSDateFormatter *)gitLabDateFormatter;
- (void)loginToHost:(NSString *)host username:(NSString *)username password:(NSString *)password success:(GLGitlabSuccessBlock)successBlock failure:(GLGitlabFailureBlock)failureBlock;

@end
