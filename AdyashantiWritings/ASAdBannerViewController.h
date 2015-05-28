//
//  ASAdBannerViewController.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-25.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface ASAdBannerViewController : UIViewController

@property ADBannerView *bannerView;
@property (weak) id<ADBannerViewDelegate> delegate;

@end
