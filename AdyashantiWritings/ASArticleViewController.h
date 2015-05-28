//
//  ASArticleViewController.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASDetailNavigationBarViewController.h"
#import "ASArticle.h"

@interface ASArticleViewController : UIViewController <ASDetailNavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *webContainerView;
@property (weak, nonatomic) IBOutlet UIView *navigationContainerView;
@property (weak, nonatomic) IBOutlet UIView *adBannerContainerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bannerHeightConstraint;

@property ASArticle *article;

@end
