//
//  GLUser.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/14/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLUser.h"

NSString *const GLUserEndpoint = @"/users";

@implementation GLUser

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        
    }
    return self;
}

@end