//
//  GLBaseObject.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/29/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLBaseObject.h"

@implementation GLBaseObject

- (instancetype)initWithJSON:(NSDictionary *)json
{
    NSAssert(false, @"Over ride in subclasses");
    return nil;
}

- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p\n%@\n>", NSStringFromClass([self class]), self, [self jsonRepresentation]];
}

- (NSDictionary *)jsonRepresentation
{
    return nil;
}

- (NSDictionary *)jsonCreateRepresentation
{
    return nil;
}

- (NSString *)checkForNull:(id)value
{
    return value == [NSNull null] ? nil : value;
}

@end