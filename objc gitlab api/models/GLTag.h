//
//  GLTag.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GLBaseObject.h"

@class GLCommit;

@interface GLTag : GLBaseObject

// name
@property (nonatomic, copy) NSString *name;
// commit
@property (nonatomic, strong) GLCommit *commit;
// protected
@property (nonatomic, assign, getter = isProtected) BOOL protectedTag;

- (BOOL)isEqualToTag:(GLTag *)tag;

@end
