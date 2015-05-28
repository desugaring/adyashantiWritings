//
//  ASMainSplitViewController.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASMainSplitViewController.h"
#import "ASArticleViewController.h"

@interface ASMainSplitViewController ()

@property ASArticleViewController *articleVC;
@property UIViewController *articlesListVC;

@end

@implementation ASMainSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.preferredDisplayMode = UISplitViewControllerDisplayModePrimaryOverlay;
    self.articlesListVC = (UIViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"TableVC"];
    self.viewControllers = @[self.articlesListVC];
    // Do any additional setup after loading the view.
}

- (void)showArticle:(ASArticle *)article {
    if (self.articleVC == nil) self.articleVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ArticleVC"];

    self.articleVC.article = article;
    self.articleVC.splitVC = self;
    [self showDetailViewController:self.articleVC sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end
