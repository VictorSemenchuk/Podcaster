//
//  FeedViewController+SettingsViewControllerDelegate.m
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController+SettingsViewControllerDelegate.h"

@implementation FeedViewController (SettingsViewControllerDelegate)

- (void)settingsWereChanged {
    [self.dataManager refetchData];
}


@end
