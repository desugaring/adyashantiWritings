//
//  ASArticlesTableViewCell.m
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-29.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import "ASArticlesTableViewCell.h"

@implementation ASArticlesTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor]; // iPad bug, cell will have white background color even though it is set to clearColor in the storyboard
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
//    if (selected == true) {
//        self.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:249.0/255.0 blue:249.0/255.0 alpha:1.0];
//    } else {
//        self.backgroundColor = [UIColor whiteColor];
//    }
}

@end
