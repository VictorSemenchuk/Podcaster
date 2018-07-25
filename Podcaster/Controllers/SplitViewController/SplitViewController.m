//
//  SplitViewController.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SplitViewController.h"
#import "FeedViewController.h"
#import "ContentViewController.h"

@interface SplitViewController () <UISplitViewControllerDelegate>

- (void)setupControllers;

@end

@implementation SplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    [self setupControllers];
}

- (void)setupControllers {
    FeedViewController *feedVC = [[FeedViewController alloc] init];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:feedVC];
    navVC.navigationBar.prefersLargeTitles = YES;
    navVC.navigationBar.translucent = YES;
    navVC.navigationBar.shadowImage = [[UIImage alloc] init];
    navVC.navigationBar.barTintColor = UIColor.whiteColor;
    
    ContentViewController *contentVC = [[ContentViewController alloc] init];
    self.viewControllers = [NSArray arrayWithObjects:navVC, contentVC, nil];
}

#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return YES;
}

@end
