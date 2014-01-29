//
//  GLBranch.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLBranch.h"
#import "GLCommit.h"

static NSString * const kName = @"name";
static NSString * const kCommit = @"commit";
static NSString * const kProtected = @"protected";

@implementation GLBranch

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _name = [self checkForNull:json[kName]];
        _commit = [[GLCommit alloc] initWithJSON:json[kCommit]];
        _branchProtected = [json[kProtected] boolValue];
    }
    
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToBranch:other];
}

- (BOOL)isEqualToBranch:(GLBranch *)branch {
    if (self == branch)
        return YES;
    if (branch == nil)
        return NO;
    if (self.name != branch.name && ![self.name isEqualToString:branch.name])
        return NO;
    if (self.commit != branch.commit && ![self.commit isEqualToCommit:branch.commit])
        return NO;
    if (self.branchProtected != branch.branchProtected)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.name hash];
    hash = hash * 31u + [self.commit hash];
    hash = hash * 31u + self.branchProtected;
    return hash;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.name=%@", self.name];
    [description appendFormat:@", self.commit=%@", self.commit];
    [description appendFormat:@", self.branchProtected=%d", self.branchProtected];
    [description appendString:@">"];
    return description;
}

- (NSDictionary *)jsonRepresentation
{
    NSNull *null = [NSNull null];
    return @{
             kName: _name ?: null,
             kCommit: [_commit jsonRepresentation],
             kProtected: @(_branchProtected)
             };
}

@end
