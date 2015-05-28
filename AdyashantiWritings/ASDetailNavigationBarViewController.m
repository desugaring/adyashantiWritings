//
//  ASDetailNavigationBarViewController.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASDetailNavigationBarViewController.h"

@interface ASDetailNavigationBarViewController ()

@end

@implementation ASDetailNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)goBack:(UIButton *)sender {
    if (self.delegate != nil) [self.delegate navBarActionInvokedWithDictionary:@{@"action": @"goBack"}];
}

- (IBAction)decreaseFontSize:(UIButton *)sender {
    if (self.delegate != nil) [self.delegate navBarActionInvokedWithDictionary:@{@"action": @"decreaseFontSize"}];
}

- (IBAction)increaseFontSize:(UIButton *)sender {
    if (self.delegate != nil) [self.delegate navBarActionInvokedWithDictionary:@{@"action": @"increaseFontSize"}];
}

- (IBAction)changeTheme:(UIButton *)sender {
   if (self.delegate != nil) [self.delegate navBarActionInvokedWithDictionary:@{@"action": @"changeTheme"}]; 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
