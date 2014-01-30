//
//  GLGitlabApi.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^GLGitlabSuccessBlock)(id responseObject);
typedef void (^GLGitlabFailureBlock)(NSError *error);

@class GLNetworkOperation;

@interface GLGitlabApi : NSObject

+ (GLGitlabApi *)sharedInstance;

- (NSDateFormatter *)gitLabDateFormatter;
- (NSDateFormatter *)dueDateFormatter;

@end
