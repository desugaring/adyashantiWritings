//
//  ASMainContainerViewController.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-28.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASArticle.h"

@protocol ASMainContainerDelegate <NSObject>

- (void)showArticle:(ASArticle *)article;

@end

@interface ASMainContainerViewController : UIViewController <ASMainContainerDelegate>

@end
