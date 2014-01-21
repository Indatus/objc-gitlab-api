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
        _newPath = json[kKeyNewPath];
        _oldPath = json[kKeyOldPath];
        _aMode = json[kKeyAMode];
        _bMode = json[kKeyBMode];
        _newFile = [json[kKeyNewFile] boolValue];
        _renamedFile = [json[kKeyRenamedFile] boolValue];
        _deletedFile = [json[kKeyDeletedFile] boolValue];
    }
    return self;
}

@end
