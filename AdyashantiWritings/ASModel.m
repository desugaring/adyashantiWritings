//
//  ASModel.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-27.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASModel.h"

@interface ASModel()

@end

@implementation ASModel

+ (instancetype)sharedModel {
    static dispatch_once_t onceToken;
    static ASModel *model;
    dispatch_once(&onceToken, ^{
        model = [[ASModel alloc] init];
    });
    return model;
}

- (instancetype)init {
    if (self = [super init]) {
        // Setup html templates
        _htmlTemplate = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"template" withExtension:@"html" subdirectory:@"HTML/templates"] encoding:NSUTF8StringEncoding error:nil];
        _footer = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"footer" withExtension:@"html" subdirectory:@"HTML/templates"] encoding:NSUTF8StringEncoding error:nil];

        // Setup articles
        NSMutableArray *articles = [NSMutableArray new];
        NSArray *articlesURLs = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"html" subdirectory:@"HTML/articles"];
        for (NSURL *url in articlesURLs) {
            [articles addObject:[[ASArticle alloc] initWithURL:url]];
        }
        _articles = articles.copy;
    }
    return self;
}

@end
