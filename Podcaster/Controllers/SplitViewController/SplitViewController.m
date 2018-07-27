//
//  SplitViewController.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "SplitViewController.h"

@interface SplitViewController () <UISplitViewControllerDelegate>

- (void)setupControllers;

@end

@implementation SplitViewController

+ (instancetype)sharedSplitViewController {
    static SplitViewController *sharedSplitViewController = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSplitViewController = [[self alloc] init];
    });
    return sharedSplitViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
    [self setupControllers];
}

- (void)setupControllers {
    self.feedVC = [[FeedViewController alloc] init];
    
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:self.feedVC];
    navVC.navigationBar.translucent = YES;
    navVC.navigationBar.shadowImage = [[UIImage alloc] init];
    navVC.navigationBar.barTintColor = UIColor.whiteColor;
    
    self.contentVC = [[ContentViewController alloc] init];
    self.viewControllers = [NSArray arrayWithObjects:navVC, self.contentVC, nil];
}

#pragma mark - UISplitViewControllerDelegate

- (BOOL)splitViewController:(UISplitViewController *)splitViewController collapseSecondaryViewController:(UIViewController *)secondaryViewController ontoPrimaryViewController:(UIViewController *)primaryViewController {
    return YES;
}

@end
