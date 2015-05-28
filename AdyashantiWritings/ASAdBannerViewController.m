//
//  ASAdBannerViewController.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASAdBannerViewController.h"

@implementation ASAdBannerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bannerView = [[ADBannerView alloc] initWithAdType:ADAdTypeBanner];
    self.bannerView.delegate = self.delegate;
    [self.view addSubview:self.bannerView];

    // Autolayout
    [self.bannerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    ADBannerView *bannerView = self.bannerView;
    [self.view addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"H:|-0-[bannerView]-0-|"
                                           options:NSLayoutFormatDirectionLeadingToTrailing
                                           metrics:nil
                                           views:NSDictionaryOfVariableBindings(bannerView)]];
    [self.view addConstraints:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"V:|-0-[bannerView]-0-|"
                                           options:NSLayoutFormatDirectionLeadingToTrailing
                                           metrics:nil
                                           views:NSDictionaryOfVariableBindings(bannerView)]];
}

@end
