//
//  ASArticle.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-27.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASArticle.h"

@interface ASArticle()

@property NSXMLParser *parser;

@end

@implementation ASArticle

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0) , ^{
            _html = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            _parser = [[NSXMLParser alloc] initWithData:[_html dataUsingEncoding:NSUTF8StringEncoding]];
            _parser.delegate = self;
            [_parser parse];
        });
    }
    return self;
}

- (void)extractTitleFromString:(NSString *)string andAddResultToArray:(NSMutableArray *)array {

}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    self.title = string;
    [parser abortParsing];
}

@end
