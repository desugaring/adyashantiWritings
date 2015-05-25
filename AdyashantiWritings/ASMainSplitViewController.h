//
//  ASMainSplitViewController.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASMainSplitViewControllerDelegate <NSObject>

- (void)goToPageSomething;

@end

@interface ASMainSplitViewController : UISplitViewController

@end