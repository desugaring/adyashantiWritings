//
//  ASThemeManager.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASThemeManager.h"

static NSString *ASThemeManagerKeyParagraphSize = @"paragraphSize";
static NSString *ASThemeManagerKeyColorTheme = @"theme";

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
        [_d registerDefaults:@{ ASThemeManagerKeyColorTheme: @(ASColorThemeTypeWhite),
                                ASThemeManagerKeyParagraphSize: @(16) }];
        [_d synchronize];
        _paragraphSize = [_d integerForKey:ASThemeManagerKeyParagraphSize];
        ASColorThemeType colorThemeType = [_d integerForKey:ASThemeManagerKeyColorTheme];
        _colorTheme = [[ASColorTheme alloc] initWithType:colorThemeType];
    }
    return self;
}

- (NSInteger)increaseParagraphSize {
    if (self.paragraphSize < 32) self.paragraphSize++;
    [self.d setInteger:self.paragraphSize forKey:ASThemeManagerKeyParagraphSize];
    return self.paragraphSize;
}

- (NSInteger)decreaseParagraphSize {
    if (self.paragraphSize > 12) self.paragraphSize--;
    [self.d setInteger:self.paragraphSize forKey:ASThemeManagerKeyParagraphSize];
    return self.paragraphSize;
}

- (ASColorTheme *)changeColorThemeType {
    self.colorTheme.theme = ((self.colorTheme.theme+1)%3);
    [self.d setInteger:self.colorTheme.theme forKey:ASThemeManagerKeyColorTheme];
    return self.colorTheme;
}

@end
