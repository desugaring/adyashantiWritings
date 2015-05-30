//
//  ASMainContainerViewController.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-28.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASMainContainerViewController.h"
#import "ASWebviewViewController.h"
#import "ASArticlesTableViewController.h"
#import "ASAdBannerViewController.h"
#import "ASModel.h"
#import "ASArticle.h"
#import "ASThemeManager.h"
#import "ASColorTheme.h"
#import "UIColor+HexColors.h"

@interface ASMainContainerViewController () <ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *mainContentView;
@property (weak, nonatomic) IBOutlet UIView *bannerView;
@property ASArticlesTableViewController *tableVC;
@property ASWebviewViewController *articleVC;
@property ASAdBannerViewController *bannerVC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *adBannerHeightConstraint;
@property ASThemeManager *theme;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *navBarButtons;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *navBarLabels;


@end

@implementation ASMainContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // TableVC init
    self.tableVC = (ASArticlesTableViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TableVC"];
    self.tableVC.delegate = self;
    [self.tableVC willMoveToParentViewController:self];
    [self addChildViewController:self.tableVC];
    [self.tableVC didMoveToParentViewController:self];

    self.tableVC.view.frame = self.mainContentView.bounds;
    [self.mainContentView addSubview:self.tableVC.view];

    // ArticleVC init
    self.articleVC = [[ASWebviewViewController alloc] init];
    self.articleVC.article = (ASArticle *)[ASModel sharedModel].articles.firstObject;
    [self.articleVC willMoveToParentViewController:self];
    [self addChildViewController:self.articleVC];
    [self.articleVC didMoveToParentViewController:self];
    
    self.articleVC.view.frame = self.mainContentView.bounds;
    [self.mainContentView insertSubview:self.articleVC.view belowSubview:self.tableVC.view];

    // BannerVC init
    self.bannerVC = [[ASAdBannerViewController alloc] init];
    self.bannerVC.delegate = self;
    [self.bannerVC willMoveToParentViewController:self];
    [self addChildViewController:self.bannerVC];
    [self.bannerVC didMoveToParentViewController:self];

    self.bannerVC.view.frame = self.bannerView.bounds;
    [self.bannerView addSubview:self.bannerVC.view];

    // Theme
    self.theme = [ASThemeManager sharedManager];
}

#pragma mark - ASMainContainer Delegate

- (void)showArticle:(ASArticle *)article {
    self.articleVC.article = article;
    [UIView animateWithDuration:0.25 animations:^{
        self.tableVC.view.center = CGPointMake(self.tableVC.view.center.x, self.tableVC.view.center.y-self.tableVC.view.bounds.size.height);
    } completion:^(BOOL finished) {
//        if (finished == true) [self.tableVC.tableView reloadData];
    }];
}

#pragma mark - AdBannerView Delegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    CGSize idealBannerSize = [self.bannerVC.bannerView sizeThatFits:self.view.bounds.size];
    [self animateBannerContainerToHeightIfNeeded:idealBannerSize.height];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [self animateBannerContainerToHeightIfNeeded:0];
}

- (void)animateBannerContainerToHeightIfNeeded:(CGFloat)height {
    if (self.adBannerHeightConstraint.constant != height) {
        [self.view layoutIfNeeded]; // this call is recommended before changing constraints to make sure the layout is good
        [UIView animateWithDuration:0.25 animations:^{
            self.adBannerHeightConstraint.constant = height;
            [self.view layoutIfNeeded]; // the constraint has been modified, tell the superview to lay out the subviews
        }];
    }
}

#pragma mark - NavBar Buttons

- (IBAction)sizeDown:(id)sender {
    [self.theme decreaseParagraphSize];
}
- (IBAction)sizeUp:(id)sender {
    [self.theme increaseParagraphSize];
}
- (IBAction)themeChange:(id)sender {
    [self.theme changeColorThemeType];
    UIColor *pColor = self.theme.colorTheme.colors[ASColorThemeKeyParagraph];
    UIColor *tColor = self.theme.colorTheme.colors[ASColorThemeKeyTitle];
    UIColor *sColor = self.theme.colorTheme.colors[ASColorThemeKeySecondary];

    self.view.backgroundColor = sColor;
    for (UIButton *button in self.navBarButtons) {
        [button setTitleColor:tColor forState:UIControlStateNormal];
    }
    for (UILabel *label in self.navBarLabels) {
        label.textColor = pColor;
    }
}
- (IBAction)learnMore:(id)sender {
    
}
- (IBAction)listOfArticles:(id)sender {
    [UIView animateWithDuration:0.25 animations:^{
        self.tableVC.view.center = self.articleVC.view.center;
    }];
}

@end
