//
//  ASColorTheme.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-29.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASColorTheme.h"

@implementation ASColorTheme

- (instancetype)initWithType:(ASColorThemeType)theme {
    if (self = [super init]) {
        _theme = theme;
    }
    return self;
}

- (NSDictionary *)colors {
    switch (self.theme) {
        case ASColorThemeTypeBlack:
            return @{ ASColorThemeKeyParagraph: [UIColor whiteColor],
                      ASColorThemeKeyTitle: [UIColor colorWithRed:0.0/255.0 green:145.0/255.0 blue:255.0/255.0 alpha:1.0],
                      ASColorThemeKeyBackground: [UIColor colorWithRed:20.0/255.0 green:20.0/255.0 blue:20.0/255.0 alpha:1.0],
                      ASColorThemeKeyBackgroundLight: [UIColor colorWithRed:35.0/255.0 green:35.0/255.0 blue:35.0/255.0 alpha:1.0],
                      ASColorThemeKeySecondary: [UIColor colorWithRed:5.0/255.0 green:10.0/255.0 blue:20.0/255.0 alpha:1.0]
                      };
            break;
        case ASColorThemeTypeWhite:
            return @{ ASColorThemeKeyParagraph: [UIColor blackColor],
                      ASColorThemeKeyTitle: [UIColor colorWithRed:0.0/255.0 green:145.0/255.0 blue:255.0/255.0 alpha:1.0],
                      ASColorThemeKeyBackground: [UIColor whiteColor],
                      ASColorThemeKeyBackgroundLight: [UIColor colorWithRed:245.0/255.0 green:245.0/255.0 blue:245.0/255.0 alpha:1.0],
                      ASColorThemeKeySecondary: [UIColor colorWithRed:10.0/255.0 green:10.0/255.0 blue:10.0/255.0 alpha:1.0]
                      };
            break;
        case ASColorThemeTypeBeige:
              return @{ ASColorThemeKeyParagraph: [UIColor colorWithRed:80.0/255.0 green:50.0/255.0 blue:27.0/255.0 alpha:1.0],
                        ASColorThemeKeyTitle: [UIColor blackColor],
                        ASColorThemeKeyBackground: [UIColor colorWithRed:248.0/255.0 green:241.0/255.0 blue:227.0/255.0 alpha:1.0],
                        ASColorThemeKeyBackgroundLight: [UIColor colorWithRed:243.0/255.0 green:236.0/255.0 blue:222.0/255.0 alpha:1.0],
                        ASColorThemeKeySecondary: [UIColor colorWithRed:238.0/255.0 green:231.0/255.0 blue:217.0/255.0 alpha:1.0]
                        };
            break;
    }
}

@end
