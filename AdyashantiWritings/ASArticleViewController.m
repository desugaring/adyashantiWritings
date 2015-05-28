//
//  ASArticleViewController.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <iAd/iAd.h>
#import "ASArticleViewController.h"
#import "ASAdBannerViewController.h"
#import "ASDetailNavigationBarViewController.h"
#import <WebKit/WebKit.h>
#import "NSString+MD5.h"

@interface ASArticleViewController () <ADBannerViewDelegate, WKScriptMessageHandler>

@property ASAdBannerViewController *bannerVC;
@property ASDetailNavigationBarViewController *navBarVC;
@property WKWebView *webView;

@end

@implementation ASArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    [config.userContentController addScriptMessageHandler:self name:@"pageLoaded"];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.webContainerView.bounds configuration:config];
    [self.webView loadHTMLString:[self stringFromFilename:@"template" extension:@"html" folder:@"HTML/templates"] baseURL:nil];
    
    [self.webContainerView addSubview:self.webView];

    // Autolayout
    [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    WKWebView *webView = self.webView;
    [self.webContainerView addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[webView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(webView)]];
    [self.webContainerView addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[webView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(webView)]];
}

- (void)dealloc {
    NSLog(@"deallocing detail");
}

- (void)navBarActionInvokedWithDictionary:(NSDictionary *)dictionary {
    NSString *action = (NSString *)dictionary[@"action"];
    if ([action isEqualToString:@"goBack"]) {
        [self dismissViewControllerAnimated:true completion:nil];

    } else if ([action isEqualToString:@"increaseFontSize"]) {
        [self.webView evaluateJavaScript:@"increaseFontSize()" completionHandler:nil];

    } else if ([action isEqualToString:@"decreaseFontSize"]) {
        [self.webView evaluateJavaScript:@"decreaseFontSize()" completionHandler:nil];

    } else if ([action isEqualToString:@"changeTheme"]) {
        
    }
}

- (void)setupWebview {
    [self refreshWithArticleNamed:@"01"];
    [self addFooterIfNeeded];
    // show/hide banner
    // hide donation if needed
}

- (void)refreshWithArticleNamed:(NSString *)articleName {
    NSString *article = [self stringFromFilename:articleName extension:@"html" folder:@"HTML/articles"];

    NSString *addArticleCode = [NSString stringWithFormat:@"document.getElementById('content').innerHTML = \"%@\";", [self escapeString:article]];
    [self.webView evaluateJavaScript:addArticleCode completionHandler:nil];
}

- (void)addFooterIfNeeded {
    NSString *footer = [self stringFromFilename:@"footer" extension:@"html" folder:@"HTML/templates"];
    NSString *md5 = [NSString md5HexDigest:footer];
    NSLog(@"md5: %@", md5);
    NSString *addFooterCode = [NSString stringWithFormat:@"document.getElementById('footer').innerHTML = \"%@\";", [self escapeString:footer]];
    [self.webView evaluateJavaScript:addFooterCode completionHandler:nil];
}

- (NSString *)stringFromFilename:(NSString *)fileName extension:(NSString *)extension folder:(NSString *)folder {
    NSString *string = [NSString stringWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:fileName ofType:extension inDirectory:folder]] encoding:NSUTF8StringEncoding error:nil];
    return string;
}

- (NSString *)escapeString:(NSString *)string {
    NSMutableString *mutableString = [string mutableCopy];
    [mutableString replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, mutableString.length)];
    [mutableString replaceOccurrencesOfString:@"\"" withString:@"\\\"" options:NSLiteralSearch range:NSMakeRange(0, mutableString.length)];
    return [mutableString copy];
}

#pragma mark - Webkit Javascript Handler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqual:@"pageLoaded"]) {
        [self setupWebview];
    }
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    CGSize idealBannerSize = [self.bannerVC.bannerView sizeThatFits:self.view.bounds.size];
    [self animateBannerContainerToHeightIfNeeded:idealBannerSize.height];
}

#pragma mark - Ad Banner Delegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    CGSize idealBannerSize = [self.bannerVC.bannerView sizeThatFits:self.view.bounds.size];
    [self animateBannerContainerToHeightIfNeeded:idealBannerSize.height];
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    [self animateBannerContainerToHeightIfNeeded:0];
}

- (void)animateBannerContainerToHeightIfNeeded:(CGFloat)height {
    if (self.bannerHeightConstraint.constant != height) {
        [self.view layoutIfNeeded]; // this call is recommended before changing constraints to make sure the layout is good
        [UIView animateWithDuration:0.25 animations:^{
            self.bannerHeightConstraint.constant = height;
            [self.view layoutIfNeeded]; // the constraint has been modified, tell the superview to lay out the subviews
        }];
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.destinationViewController isKindOfClass:[ASDetailNavigationBarViewController class]]) {
        self.navBarVC = (ASDetailNavigationBarViewController *)segue.destinationViewController;
        self.navBarVC.delegate = self;
    } else if ([segue.destinationViewController isKindOfClass:[ASAdBannerViewController class]]) {
        self.bannerVC = (ASAdBannerViewController *)segue.destinationViewController;
        self.bannerVC.delegate = self;
    }
}

@end
