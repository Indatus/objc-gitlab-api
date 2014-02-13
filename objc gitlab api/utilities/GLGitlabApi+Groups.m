//
// Created by Jeff Trespalacios on 2/13/14.
// Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLGitlabApi+Groups.h"
#import "GLGitlabApi+Private.h"
#import "GLGroup.h"

@implementation GLGitlabApi (Groups)

- (GLNetworkOperation *)getUsersGroupsWithSuccessBlock:(GLGitlabSuccessBlock)success
                                       andFailureBlock:(GLGitlabFailureBlock)failure
{
    NSURL *url = [self requestUrlForEndPoint:@"/groups"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = GLNetworkOperationGetMethod;

    GLNetworkOperationSuccessBlock localSuccessBlock = ^(NSArray *responseObject) {
        NSArray *groups = [self processJsonArray:responseObject class:[GLGroup class]];
        success(groups);
    };

    GLNetworkOperationFailureBlock localFailureBlock = [self defaultFailureBlock:failure];

    return [self queueOperationWithRequest:request
                                      type:GLNetworkOperationTypeJson
                                   success:localSuccessBlock
                                   failure:localFailureBlock];
}
@end