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

static const NSString *ASColorThemeKeyBackground = @"background";
static const NSString *ASColorThemeKeyParagraph = @"paragraph";
static const NSString *ASColorThemeKeyTitle = @"title";
static const NSString *ASColorThemeKeySecondary = @"secondary";

@interface ASColorTheme : NSObject

@property ASColorThemeType type;
@property (readonly) NSDictionary *colors;

- (instancetype)initWithType:(ASColorThemeType)type;

@end
