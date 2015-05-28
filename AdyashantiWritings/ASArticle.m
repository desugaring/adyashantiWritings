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
@property dispatch_semaphore_t parseSemaphore;

@end

@implementation ASArticle

- (instancetype)initWithURL:(NSURL *)url {
    if (self = [super init]) {
        _parseSemaphore = dispatch_semaphore_create(0);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0) , ^{
            _html = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
            _parser = [[NSXMLParser alloc] initWithData:[_html dataUsingEncoding:NSUTF8StringEncoding]];
            _parser.delegate = self;
            [_parser parse];
        });
    }
    // Wait for the parsing to finish, we want html and title to be ready before we return the object
    dispatch_semaphore_wait(_parseSemaphore, DISPATCH_TIME_FOREVER);
    return self;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    self.title = string;
    [parser abortParsing];
    dispatch_semaphore_signal(self.parseSemaphore);
}

@end
