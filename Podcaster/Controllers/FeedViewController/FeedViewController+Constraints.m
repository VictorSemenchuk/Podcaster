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
    [self.collectionView addSubview:self.activityIndicator];
    [NSLayoutConstraint activateConstraints:@[[self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.collectionView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              [self.activityIndicator.topAnchor constraintEqualToAnchor:self.collectionView.topAnchor constant:50.0],
                                              [self.activityIndicator.centerXAnchor constraintEqualToAnchor:self.collectionView.centerXAnchor],
                                              [self.activityIndicator.widthAnchor constraintEqualToConstant:20.0],
                                              [self.activityIndicator.heightAnchor constraintEqualToAnchor:self.activityIndicator.widthAnchor]
                                              ]];
    [self.activityIndicator startAnimating];
}

@end
