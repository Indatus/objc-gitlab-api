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

- (NSString *)jsonString
{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[self jsonRepresentation]
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error) {
        NSLog(@"Error creating JSON string: %@", error);
        return @"";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

- (id)checkForNull:(id)value
{
    return value == [NSNull null] ? nil : value;
}

@end