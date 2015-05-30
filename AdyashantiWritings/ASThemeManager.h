//
//  ASThemeManager.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASColorTheme.h"

@interface ASThemeManager : NSObject

@property (readonly) ASColorTheme *colorTheme;
@property (readonly) NSInteger paragraphSize;

+ (instancetype)sharedManager;

- (NSInteger)increaseParagraphSize;
- (NSInteger)decreaseParagraphSize;
//- (void)setParagraphSizeTo:(NSUInteger)size;

- (ASColorTheme *)changeColorThemeType;
//- (void)changeColorThemeTo:(ASThemeManagerColorTheme)theme;

@end
