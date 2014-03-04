//
//  GLFile.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLFile.h"

// JSON Keys
static NSString * const kName = @"name";
static NSString * const kType = @"type";
static NSString * const kMode = @"mode";
static NSString * const kId   = @"id";

// File Type Values
static NSString * const kTreeType = @"tree";
static NSString * const kBlobType = @"blob";

@implementation GLFile

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if ((self = [super init])) {
        _name = [self checkForNull:json[kName]];
        if ([json[kType] isEqualToString:kTreeType]) {
            _type = GLFileTypeTree;
        }
        else if ([json[kType] isEqualToString:kBlobType]) {
            _type = GLFileTypeBlob;
        }
        _fileId = json[kId];
        _mode = json[kMode];
    }
    
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToFile:other];
}

- (BOOL)isEqualToFile:(GLFile *)file {
    if (self == file)
        return YES;
    if (file == nil)
        return NO;
    if (self.fileId != file.fileId && ![self.fileId isEqualToString:file.fileId])
        return NO;
    if (self.name != file.name && ![self.name isEqualToString:file.name])
        return NO;
    if (self.mode != file.mode && ![self.mode isEqualToString:file.mode])
        return NO;
    if (self.type != file.type)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.fileId hash];
    hash = hash * 31u + [self.name hash];
    hash = hash * 31u + [self.mode hash];
    hash = hash * 31u + (NSUInteger) self.type;
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.fileId=%@", self.fileId];
    [description appendFormat:@", self.name=%@", self.name];
    [description appendFormat:@", self.mode=%@", self.mode];
    [description appendFormat:@", self.type=%d", self.type];
    [description appendString:@">"];
    return description;
}

- (NSString *)nameWithoutExtension
{
    NSRange range = [_name rangeOfString:@"." options:NSBackwardsSearch];
    return [_name substringToIndex:range.location];
}

@end
