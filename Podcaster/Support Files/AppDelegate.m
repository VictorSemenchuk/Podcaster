//
//  AppDelegate.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "AppDelegate.h"
#import "FeedViewController.h"
#import "ContentViewController.h"
#import "SplitViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CGRect screenFrame = UIScreen.mainScreen.bounds;
    UIWindow *window = [[UIWindow alloc] initWithFrame:screenFrame];
    SplitViewController *splitViewController = [SplitViewController sharedSplitViewController];
    window.rootViewController = splitViewController;
    self.window = window;
    [window makeKeyAndVisible];
    return YES;
}

@end
