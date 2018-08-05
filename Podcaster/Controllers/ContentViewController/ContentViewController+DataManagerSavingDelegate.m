//
//  ContentViewController+DataManagerSavingDelegate.m
//  Podcaster
//
//  Created by Victor Macintosh on 05/08/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ContentViewController+DataManagerSavingDelegate.h"

@implementation ContentViewController (DataManagerSavingDelegate)

#pragma mark - DataManagerSavingDelegate

- (void)wasFinishedBackgroundDownloadingForItem:(Item *)item {
    self.item.content.localUrl = item.content.localUrl;
    self.progressView.hidden = YES;
    [self.activityView stopAnimating];
    self.removeButton.hidden = NO;
    [self.delegate persistentWasChanged];
}

- (void)updatedProgressFor:(float)progess {
    self.progressView.hidden = NO;
    [self.activityView startAnimating];
    self.removeButton.hidden = YES;
    self.progressView.progress = progess;
}

@end
