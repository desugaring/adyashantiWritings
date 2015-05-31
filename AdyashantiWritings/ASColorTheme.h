//
//  ASColorTheme.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-29.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

@import UIKit;

typedef NS_ENUM(NSInteger, ASColorThemeType) {
    ASColorThemeTypeBlack,
    ASColorThemeTypeWhite,
    ASColorThemeTypeBeige
};

static NSString *ASColorThemeKeyBackground = @"background";
static NSString *ASColorThemeKeyBackgroundLight = @"backgroundLight";
static NSString *ASColorThemeKeyParagraph = @"paragraph";
static NSString *ASColorThemeKeyTitle = @"title";
static NSString *ASColorThemeKeySecondary = @"secondary";

@interface ASColorTheme : NSObject

@property ASColorThemeType theme;
@property (readonly) NSDictionary *colors;

- (instancetype)initWithType:(ASColorThemeType)type;

@end
