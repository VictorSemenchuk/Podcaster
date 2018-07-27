//
//  SplitViewController.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"
#import "ContentViewController.h"

@interface SplitViewController : UISplitViewController

@property (nonatomic) FeedViewController *feedVC;
@property (nonatomic) ContentViewController *contentVC;

+ (instancetype)sharedSplitViewController;

@end
