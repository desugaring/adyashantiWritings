//
//  NSString+MD5.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-27.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5)

+ (NSString*)md5HexDigest:(NSString*)input;

@end
