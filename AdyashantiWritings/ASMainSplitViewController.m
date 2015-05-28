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

@end

@implementation ASMainSplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    for (id vc in self.viewControllers) {
        if ([vc isKindOfClass:[ASArticleViewController class]] == true) {
            self.articleVC = (ASArticleViewController *)vc;
        }
    }
    // Do any additional setup after loading the view.
}

- (void)showArticle:(ASArticle *)article {
    self.articleVC.article = article;
    [self showDetailViewController:self.articleVC sender:self];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}


@end
