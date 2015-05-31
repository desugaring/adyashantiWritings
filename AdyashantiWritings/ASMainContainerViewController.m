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
@property (weak, nonatomic) IBOutlet UILabel *logo;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *webviewButtons;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonsRightOfLogoConstraint;

@end

@implementation ASMainContainerViewController

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        self.logo.hidden = [self hideLogo];
        self.logo.alpha = self.logo.hidden ? 0.0 : 1.0;

        // If the logo is visible, place the buttons to the right of it,
        // otherwise there's a 750 constraint that places them where the logo is
        self.buttonsRightOfLogoConstraint.priority = self.logo.hidden ? 749 : 751;
        [self.view setNeedsLayout];
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        //
    }];
}

- (BOOL)hideLogo {
    // If it's a phone, portrait mode and we're on a webview, hide the logo
    return (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && self.view.bounds.size.width < self.view.bounds.size.height && self.tableVC.view.hidden == true);
}

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

- (UIStatusBarStyle)preferredStatusBarStyle {
    return (self.theme.colorTheme.type == ASColorThemeTypeBlack) ? UIStatusBarStyleLightContent : UIStatusBarStyleDefault;
}

#pragma mark - ASMainContainer Delegate

- (void)showArticle:(ASArticle *)article {
    self.articleVC.article = article;
    for (UIButton *button in self.webviewButtons) {
        button.hidden = false;
        button.alpha = 0;
    }
    [UIView animateWithDuration:0.25 animations:^{
        // Scroll the tableview offscreen
        self.tableVC.view.center = CGPointMake(self.articleVC.view.center.x, self.articleVC.view.center.y-self.articleVC.view.bounds.size.height);
        // If we're on a phone and in portrait mode, the logo is going to be replaced by buttons
        if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && self.view.bounds.size.width < self.view.bounds.size.height) self.logo.alpha = 0;

    } completion:^(BOOL finished) {
        if (finished == true) {
            self.tableVC.view.hidden = true;
            if (self.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassCompact && self.view.bounds.size.width < self.view.bounds.size.height) self.logo.hidden = true;
            [UIView animateWithDuration:0.1 animations:^{
                for (UIButton *button in self.webviewButtons) {
                    button.alpha = 1;
                }
            }];
        }

    }];
}

#pragma mark - NavBar Buttons

- (IBAction)listOfArticles:(id)sender {
    self.logo.hidden = false;
    // Position tableview right above the article, this may have gotten screwed up due to screen rotations
    self.tableVC.view.center = CGPointMake(self.articleVC.view.center.x, self.articleVC.view.center.y-self.articleVC.view.bounds.size.height);
    self.tableVC.view.hidden = false;
    [UIView animateWithDuration:0.25 animations:^{
        self.tableVC.view.center = self.articleVC.view.center;
        for (UIButton *button in self.webviewButtons) {
            button.alpha = 0;
        }
    } completion:^(BOOL finished) {
        if (finished == true) {
            for (UIButton *button in self.webviewButtons) {
                button.hidden = true;
            }
            [UIView animateWithDuration:0.1 animations:^{
                self.logo.alpha = 1;
            }];
        }
    }];
}

- (IBAction)sizeDown:(id)sender {
    [self.theme decreaseParagraphSize];
    [[UIApplication sharedApplication] setStatusBarHidden:true];
//    [[UIApplication sharedApplication] setStatusBarHidden:false];
}

- (IBAction)sizeUp:(id)sender {
    [self.theme increaseParagraphSize];
}

- (IBAction)themeChange:(id)sender {
    [self.theme changeColorThemeType];
}

- (IBAction)learnMore:(id)sender {

}

@end
