//
//  FeedViewController+Constraints.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "FeedViewController+Constraints.h"

@implementation FeedViewController (Constraints)

- (void)setupViews {
    self.navigationItem.title = @"Feed";
    
    [self.view addSubview:self.collectionView];
    [NSLayoutConstraint activateConstraints:@[[self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              ]];
}

@end
