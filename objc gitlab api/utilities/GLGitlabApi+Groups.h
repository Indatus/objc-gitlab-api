//
// Created by Jeff Trespalacios on 2/13/14.
// Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLGitlabApi.h"

@interface GLGitlabApi (Groups)
- (GLNetworkOperation *)getUsersGroupsWithSuccessBlock:(GLGitlabSuccessBlock)success
                                    andFailureBlock:(GLGitlabFailureBlock)failure;
@end