//
//  GLDiff.h
//  objc gitlab api
//
//  Created by Jon Staff on 1/16/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLDiff : NSObject

// diff
@property (nonatomic, copy) NSString *diff;
// new_path
@property (nonatomic, copy) NSString *updatedPath;
// old_path
@property (nonatomic, copy) NSString *oldPath;
// a_mode
@property (nonatomic, copy) NSString *aMode;
// b_mode
@property (nonatomic, copy) NSString *bMode;
// new_file
@property (nonatomic, getter = isNewFile) BOOL newFile;
// renamed_file
@property (nonatomic, getter = isRenamedFile) BOOL renamedFile;
// deleted_file
@property (nonatomic, getter = isDeletedFile) BOOL deletedFile;

@end
