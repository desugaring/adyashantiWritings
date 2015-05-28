//
//  ASModel.h
//  AdyashantiWritings
//
//  Created by Alex Semenikhine on 2015-05-27.
//  Copyright (c) 2015 Alex Semenikhine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASArticle.h"

@interface ASModel : NSObject

+ (instancetype)sharedModel;

@property NSArray *articles;

@end
