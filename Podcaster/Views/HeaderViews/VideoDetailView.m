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
    [self addSubview:self.playButton];
    [NSLayoutConstraint activateConstraints: @[[self.imageView.heightAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.5625],
                                               [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                               [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                               [self.imageView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                               [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                               [self.titleLabel.topAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:kTopBottomPadding - 5.0],
                                               [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                               [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                               [self.playButton.widthAnchor constraintEqualToConstant:30.0],
                                               [self.playButton.heightAnchor constraintEqualToAnchor:self.playButton.widthAnchor],
                                               [self.playButton.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:-10.0],
                                               [self.playButton.trailingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:-10.0]
                                               ]];
    [self.titleLabel sizeToFit];
}

@end
