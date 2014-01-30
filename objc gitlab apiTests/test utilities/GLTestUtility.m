//
//  GLTestUtility.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/30/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLTestUtility.h"

@implementation GLTestUtility

+ (id)loadJsonFile:(NSString *)fileName
{
    NSError *error;
    NSString *path = [[NSBundle bundleForClass:[self class]] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    id object = [NSJSONSerialization JSONObjectWithData:data
                                                options:0
                                                  error:&error];
    
    NSAssert(!error, @"An error has occurred loading json, %@", error.localizedDescription);
    
    return object;
}

@end
