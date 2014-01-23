//
//  GLBranch.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GLCommit;

@interface GLBranch : NSObject

// name
@property (nonatomic, copy) NSString *name;
// commit
@property (nonatomic, strong) GLCommit *commit;
// protected
@property (nonatomic, assign, getter = isProtected) BOOL branchProtected;

- (instancetype)initWithJSON:(NSDictionary *)json;

- (NSDictionary *)jsonRepresentation;
- (NSDictionary *)jsonCreateRepresentation;

- (BOOL)isEqual:(id)other;
- (BOOL)isEqualToBranch:(GLBranch *)branch;
- (NSUInteger)hash;
- (NSString *)description;

@end
