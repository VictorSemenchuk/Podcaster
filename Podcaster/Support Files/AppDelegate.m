//
//  AppDelegate.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "AppDelegate.h"
#import "SplitViewController.h"
#import "Constants.h"

@interface AppDelegate ()

- (void)setDefaultValuesForUserDefaultsIfNeeded;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setDefaultValuesForUserDefaultsIfNeeded];
    CGRect screenFrame = UIScreen.mainScreen.bounds;
    UIWindow *window = [[UIWindow alloc] initWithFrame:screenFrame];
    SplitViewController *splitViewController = [SplitViewController sharedSplitViewController];
    window.rootViewController = splitViewController;
    self.window = window;
    [window makeKeyAndVisible];
    return YES;
}

- (void)setDefaultValuesForUserDefaultsIfNeeded {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    if (![userDefaults objectForKey:kUserDefaultsMP3SourceKey]) {
        [userDefaults setBool:YES forKey:kUserDefaultsMP3SourceKey];
    }
    if (![userDefaults objectForKey:kUserDefaultsTEDSourceKey]) {
        [userDefaults setBool:YES forKey:kUserDefaultsTEDSourceKey];
    }
    if (![userDefaults objectForKey:kUserDefaultsOfflineModeKey]) {
        [userDefaults setBool:NO forKey:kUserDefaultsOfflineModeKey];
    }
}

@end
