//
//  ASThemeManager.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASThemeManager.h"

@interface ASThemeManager()

@property (readwrite) NSInteger paragraphSize;
@property (readwrite) ASColorTheme *colorTheme;
@property NSUserDefaults *d;

@end

@implementation ASThemeManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static ASThemeManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[ASThemeManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    if (self = [super init]) {
        _d = [NSUserDefaults standardUserDefaults];
        [_d registerDefaults:@{ @"theme": @(ASColorThemeTypeWhite),
                                                                   @"paragraphSize": @(16) }];
        [_d synchronize];
        _paragraphSize = [_d integerForKey:@"paragraphSize"];
        ASColorThemeType colorThemeType = [_d integerForKey:@"theme"];
        _colorTheme = [[ASColorTheme alloc] initWithType:colorThemeType];
    }
    return self;
}

- (NSInteger)increaseParagraphSize {
    if (self.paragraphSize < 32) self.paragraphSize++;
    return self.paragraphSize;
}

- (NSInteger)decreaseParagraphSize {
    if (self.paragraphSize > 12) self.paragraphSize--;
    return self.paragraphSize;
}

- (ASColorTheme *)changeColorThemeType {
    self.colorTheme.type = ((self.colorTheme.type+1)%3);
    return self.colorTheme;
}

@end
