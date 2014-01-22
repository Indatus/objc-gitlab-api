//
//  GLGitlab_Testing.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/21/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi.h"

@interface GLGitlabApi (Testing)
- (NSString *)privateToken;
- (NSOperationQueue *)queue;
@end
