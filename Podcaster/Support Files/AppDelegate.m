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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    CGRect screenFrame = UIScreen.mainScreen.bounds;
    UIWindow *window = [[UIWindow alloc] initWithFrame:screenFrame];
    
    UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
    
    FeedViewController *feedVC = [[FeedViewController alloc] init];
    ContentViewController *contentVC = [[ContentViewController alloc] init];
    
    splitViewController.viewControllers = [NSArray arrayWithObjects:feedVC, contentVC, nil];
    window.rootViewController = splitViewController;
    
    self.window = window;
    [window makeKeyAndVisible];
    
    return YES;
}

@end
