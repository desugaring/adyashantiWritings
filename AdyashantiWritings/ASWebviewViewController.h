//
//  ASWebviewViewController.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASArticle.h"
#import "ASColorTheme.h"
#import <WebKit/WebKit.h>

@interface ASWebviewViewController : UIViewController

@property WKWebView *webView;
@property ASArticle *article;

@end
