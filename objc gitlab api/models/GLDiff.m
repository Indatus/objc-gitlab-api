//
//  GLDiff.m
//  objc gitlab api
//
//  Created by Jon Staff on 1/16/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLDiff.h"

NSString * const kKeyDiff = @"diff";
NSString * const kKeyNewPath = @"new_path";
NSString * const kKeyOldPath = @"old_path";
NSString * const kKeyAMode = @"a_mode";
NSString * const kKeyBMode = @"b_mode";
NSString * const kKeyNewFile = @"new_file";
NSString * const kKeyRenamedFile = @"renamed_file";
NSString * const kKeyDeletedFile = @"deleted_file";

@implementation GLDiff

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _diff = json[kKeyDiff];
        _updatedPath = json[kKeyNewPath];
        _oldPath = json[kKeyOldPath];
        _aMode = json[kKeyAMode];
        _bMode = json[kKeyBMode];
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

@end
