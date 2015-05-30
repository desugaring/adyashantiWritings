//
//  ASArticlesTableViewController.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-26.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASMainContainerViewController.h"

@interface ASArticlesTableViewController : UITableViewController

@property (weak) id<ASMainContainerDelegate> delegate;

@end
