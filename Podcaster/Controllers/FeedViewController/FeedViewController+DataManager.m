//
//  FeedViewController+DataManager.m
//  Podcaster
//
//  Created by Victor Macintosh on 28/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController+DataManager.h"

@implementation FeedViewController (DataManager)

- (void)dataWasFetched:(NSArray *)items {
    self.items = items;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.activityIndicator stopAnimating];
        [self.collectionView reloadData];
    });
}

@end
