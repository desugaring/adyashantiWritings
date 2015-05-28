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
        NSMutableArray *articles = [NSMutableArray new];
        NSArray *articlesURLs = [[NSBundle mainBundle] URLsForResourcesWithExtension:@"html" subdirectory:@"HTML/articles"];
        for (NSURL *url in articlesURLs) {
            [articles addObject:[[ASArticle alloc] initWithURL:url]];
        }
    }
    return self;
}

@end
