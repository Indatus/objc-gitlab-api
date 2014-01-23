//
//  GLTag.m
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/22/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import "GLTag.h"
#import "GLCommit.h"

static NSString * const kName = @"name";
static NSString * const kCommit = @"commit";
static NSString * const kProtected = @"protected";

@implementation GLTag

- (BOOL)isEqual:(id)other {
    if (other == self)
        return YES;
    if (!other || ![[other class] isEqual:[self class]])
        return NO;

    return [self isEqualToTag:other];
}

- (BOOL)isEqualToTag:(GLTag *)tag {
    if (self == tag)
        return YES;
    if (tag == nil)
        return NO;
    if (self.name != tag.name && ![self.name isEqualToString:tag.name])
        return NO;
    if (self.commit != tag.commit && ![self.commit isEqualToCommit:tag.commit])
        return NO;
    if (self.protectedTag != tag.protectedTag)
        return NO;
    return YES;
}

- (NSUInteger)hash {
    NSUInteger hash = [self.name hash];
    hash = hash * 31u + [self.commit hash];
    hash = hash * 31u + self.protectedTag;
    return hash;
}

- (instancetype)initWithJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        _name = json[kName];
        _commit = [[GLCommit alloc] initWithJSON:json[kCommit]];
        _protectedTag = [json[kProtected] boolValue];
    }

    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"self.name=%@", self.name];
    [description appendFormat:@", self.commit=%@", self.commit];
    [description appendFormat:@", self.protectedTag=%d", self.protectedTag];
    [description appendString:@">"];
    return description;
}


@end
