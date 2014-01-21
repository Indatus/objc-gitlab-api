//
//  GLJsonInit.h
//  objc gitlab api
//
//  Created by Jeff Trespalacios on 1/21/14.
//  Copyright (c) 2014 Indatus. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GLJsonInit <NSObject>
- (instancetype)initWithJSON:(NSDictionary *)json;
@end
