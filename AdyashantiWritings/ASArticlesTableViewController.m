//
//  ASArticlesTableViewController.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-26.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASArticlesTableViewController.h"
#import "ASWebviewViewController.h"
#import "ASArticlesTableViewCell.h"
#import "ASModel.h"
#import "ASThemeManager.h"

@interface ASArticlesTableViewController ()

@property ASWebviewViewController *articleVC;
@property NSArray *articles;
@property ASThemeManager *theme;

@end

@implementation ASArticlesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.articles = [ASModel sharedModel].articles;
    self.theme = [ASThemeManager sharedManager];
    [self.theme.colorTheme addObserver:self forKeyPath:@"theme" options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial) context:nil];
}

- (void)dealloc {
    [self.theme.colorTheme removeObserver:self forKeyPath:@"theme"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.articles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ASArticlesTableViewCell *cell = (ASArticlesTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = ((ASArticle *)self.articles[indexPath.row]).title;
    cell.textLabel.textColor = self.theme.colorTheme.colors[ASColorThemeKeyParagraph];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate showArticle:self.articles[indexPath.row]];
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"theme"]) {
        [UIView animateWithDuration:0.25 animations:^{
            self.tableView.backgroundColor = self.theme.colorTheme.colors[ASColorThemeKeyBackground];
        }];
        // The tableview needs to reload it's cells for them to reflect the new theme
        NSIndexPath *selectedRow = [self.tableView indexPathForSelectedRow];
        [self.tableView reloadData];
        [self.tableView selectRowAtIndexPath:selectedRow animated:false scrollPosition:UITableViewScrollPositionNone];
    }
}

@end
