//
//  GLDiff.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/16/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLDiff.h"

static NSString * const kKeyDiff = @"diff";
static NSString * const kKeyNewPath = @"new_path";
static NSString * const kKeyOldPath = @"old_path";
static NSString * const kKeyAMode = @"a_mode";
static NSString * const kKeyBMode = @"b_mode";
static NSString * const kKeyNewFile = @"new_file";
static NSString * const kKeyRenamedFile = @"renamed_file";
static NSString * const kKeyDeletedFile = @"deleted_file";

@implementation GLDiff

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if ((self = [super init])) {
        _diff = [self checkForNull:json[kKeyDiff]];
        _updatedPath = [self checkForNull:json[kKeyNewPath]];
        _oldPath = [self checkForNull:json[kKeyOldPath]];
        _aMode = [self checkForNull:json[kKeyAMode]];
        _bMode = [self checkForNull:json[kKeyBMode]];
        _newFile = [json[kKeyNewFile] boolValue];
        _renamedFile = [json[kKeyRenamedFile] boolValue];
        _deletedFile = [json[kKeyDeletedFile] boolValue];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToDiff:other];
}

- (BOOL)isEqualToDiff:(GLDiff *)diff {
    if (self == diff)
        return YES;
    if (diff == nil)
        return NO;
    if (self.diff != diff.diff && ![self.diff isEqualToString:diff.diff])
        return NO;
    if (self.updatedPath != diff.updatedPath && ![self.updatedPath isEqualToString:diff.updatedPath])
        return NO;
    if (self.oldPath != diff.oldPath && ![self.oldPath isEqualToString:diff.oldPath])
        return NO;
    if (self.aMode != diff.aMode && ![self.aMode isEqualToString:diff.aMode])
        return NO;
    if (self.bMode != diff.bMode && ![self.bMode isEqualToString:diff.bMode])
        return NO;
    if (self.newFile != diff.newFile)
        return NO;
    if (self.renamedFile != diff.renamedFile)
        return NO;
    if (self.deletedFile != diff.deletedFile)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.diff hash];
    hash = hash * 31u + [self.updatedPath hash];
    hash = hash * 31u + [self.oldPath hash];
    hash = hash * 31u + [self.aMode hash];
    hash = hash * 31u + [self.bMode hash];
    hash = hash * 31u + self.newFile;
    hash = hash * 31u + self.renamedFile;
    hash = hash * 31u + self.deletedFile;
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.diff=%@", self.diff];
    [description appendFormat:@", self.updatedPath=%@", self.updatedPath];
    [description appendFormat:@", self.oldPath=%@", self.oldPath];
    [description appendFormat:@", self.aMode=%@", self.aMode];
    [description appendFormat:@", self.bMode=%@", self.bMode];
    [description appendFormat:@", self.newFile=%d", self.newFile];
    [description appendFormat:@", self.renamedFile=%d", self.renamedFile];
    [description appendFormat:@", self.deletedFile=%d", self.deletedFile];
    [description appendString:@">"];
    return description;
}

- (NSDictionary *)jsonRepresentation
{
    NSNull *null = [NSNull null];
    return @{
             kKeyDiff: _diff ?: null,
             kKeyNewPath: _updatedPath ?: null,
             kKeyOldPath: _oldPath ?: null,
             kKeyAMode: _aMode ?: null,
             kKeyBMode: _bMode ?: null,
             kKeyNewFile: @(_newFile),
             kKeyRenamedFile: @(_newFile),
             kKeyDeletedFile: @(_deletedFile)
             };
}

@end
