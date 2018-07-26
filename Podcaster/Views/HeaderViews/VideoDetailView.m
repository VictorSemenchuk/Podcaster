//
//  VideoDetailView.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/26/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "VideoDetailView.h"

@implementation VideoDetailView

#pragma mark - Methods

- (void)setupViews {
    self.imageView.image = [UIImage imageNamed:kTEDItemImagePlaceholderHuge];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [NSLayoutConstraint activateConstraints: @[[self.imageView.heightAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.5625],
                                               [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:kTopBottomPadding],
                                               [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                               [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                               [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                               [self.titleLabel.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:kTopBottomPadding - 5.0],
                                               [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                               [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]
                                               ]];
}

@end
