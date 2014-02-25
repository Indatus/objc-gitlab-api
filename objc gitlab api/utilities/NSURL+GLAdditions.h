//
//  NSURL+GLAdditions.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 2/25/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSURL (GLAdditions)

- (NSURL *)URLByAppendingQueryString:(NSString *)queryString;

@end
