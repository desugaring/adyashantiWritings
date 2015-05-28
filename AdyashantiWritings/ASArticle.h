//
//  ASArticle.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-27.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASArticle : NSObject <NSXMLParserDelegate>

@property NSString *title;
@property NSString *html;

- (instancetype)initWithURL:(NSURL *)url;

@end
