//
//  ASDetailNavigationBarViewController.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ASDetailNavigationBarDelegate <NSObject>

- (void)navBarActionInvokedWithDictionary:(NSDictionary *)dictionary;

@end

@interface ASDetailNavigationBarViewController : UIViewController

@property (weak) id<ASDetailNavigationBarDelegate> delegate;

@end
