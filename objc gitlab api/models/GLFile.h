//
//  GLFile.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 2/13/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLBaseObject.h"

typedef NS_ENUM(NSInteger, GLFileType) {
    GLFileTypeTree,
    GLFileTypeBlob
};

@interface GLFile : GLBaseObject

// id
@property (nonatomic, copy) NSString *fileId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *mode;
@property (nonatomic) GLFileType type;


- (BOOL)isEqual:(id)other;

- (BOOL)isEqualToFile:(GLFile *)file;

- (NSUInteger)hash;

- (NSString *)description;

- (NSString *)nameWithoutExtension;

@end
