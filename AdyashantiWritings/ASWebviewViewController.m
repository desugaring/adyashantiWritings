//
//  ASWebviewViewController.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <iAd/iAd.h>
#import "ASWebviewViewController.h"
#import "ASModel.h"
#import "ASThemeManager.h"
#import "UIColor+HexColors.h"

@interface ASWebviewViewController () <ADBannerViewDelegate, WKScriptMessageHandler>

@property ASThemeManager *theme;

@end

@implementation ASWebviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Webview setup
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    // Before running any JS scripts, the page must first fully load
    [config.userContentController addScriptMessageHandler:self name:@"pageLoaded"];
    [config.userContentController addScriptMessageHandler:self name:@"presentModal"];

    // Layout for webview
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds configuration:config];
    [self.view addSubview:self.webView];

    WKWebView *webView = self.webView;
    [self.webView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"H:|-0-[webView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(webView)]];
    [self.view addConstraints:[NSLayoutConstraint
                               constraintsWithVisualFormat:@"V:|-0-[webView]-0-|"
                               options:NSLayoutFormatDirectionLeadingToTrailing
                               metrics:nil
                               views:NSDictionaryOfVariableBindings(webView)]];
    // Loading the webpage
    [self.webView loadHTMLString:[ASModel sharedModel].htmlTemplate baseURL:nil];

    // This is how the article gets set by the superview
    [self addObserver:self forKeyPath:@"article" options:(NSKeyValueObservingOptionNew) context:nil];

    // Theme
    self.theme = [ASThemeManager sharedManager];
    [self.theme addObserver:self forKeyPath:@"paragraphSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.theme.colorTheme addObserver:self forKeyPath:@"theme" options:(NSKeyValueObservingOptionNew) context:nil];
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"article"];
    [self.theme removeObserver:self forKeyPath:@"paragraphSize"];
    [self.theme.colorTheme removeObserver:self forKeyPath:@"theme"];
}

- (void)setupWebview {
    [self setTheme];
    [self setFooter];
    [self setParagraphSize];
    if (self.article != nil) [self setArticle];
}

- (void)setArticle {
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"changeArticleTo(\"%@\");", [self escapeString:self.article.html]] completionHandler:nil];
}

- (void)setParagraphSize {
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"changeParagraphFontSize(%li)", (long)self.theme.paragraphSize] completionHandler:nil];
}

- (void)setTheme {
    UIColor *tColor = self.theme.colorTheme.colors[ASColorThemeKeyTitle];
    UIColor *bgColor = self.theme.colorTheme.colors[ASColorThemeKeyBackground];
    UIColor *pColor = self.theme.colorTheme.colors[ASColorThemeKeyParagraph];
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"changeTitleColor(\"%@\")", [UIColor hexValuesFromUIColor:tColor]] completionHandler:nil];
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"changeBackgroundColor(\"%@\")", [UIColor hexValuesFromUIColor:bgColor]] completionHandler:nil];
    [self.webView evaluateJavaScript:[NSString stringWithFormat:@"changeParagraphColor(\"%@\")", [UIColor hexValuesFromUIColor:pColor]] completionHandler:nil];
}

- (void)setFooter {
     [self.webView evaluateJavaScript:[NSString stringWithFormat:@"changeFooterTo(\"%@\");", [self escapeString:[ASModel sharedModel].footer]] completionHandler:nil];
}

#pragma mark - Webkit Javascript Handler

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"pageLoaded"]) {
        [self setupWebview];
    } else if ([message.name isEqualToString:@"presentModal"]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.adyashanti.org/index.php?file=writings"]];
    }
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"article"]) {
        [self setArticle];
    } else if ([keyPath isEqualToString:@"theme"]) {
        [self setTheme];
    } else if ([keyPath isEqualToString:@"paragraphSize"]) {
        [self setParagraphSize];
    }
}

#pragma mark - HTML File helpers

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

@end
