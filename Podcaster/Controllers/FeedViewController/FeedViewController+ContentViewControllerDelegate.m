//
//  FeedViewController+ContentViewControllerDelegate.m
//  Podcaster
//
//  Created by Victor Macintosh on 29/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController+ContentViewControllerDelegate.h"

@implementation FeedViewController (ContentViewControllerDelegate)

- (void)persistentWasChanged {
    [self.dataManager refetchData];
}

@end
