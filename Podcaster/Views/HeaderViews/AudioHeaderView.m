//
//  AudioHeaderView.m
//  Podcaster
//
//  Created by Victor Macintosh on 26/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "AudioHeaderView.h"

@implementation AudioHeaderView

- (void)setupViews {
    self.imageView.image = [UIImage imageNamed:kMP3ItemImagePlaceholder];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [NSLayoutConstraint activateConstraints: @[[self.imageView.heightAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.2],
                                               [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:kTopBottomPadding],
                                               [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                               [self.imageView.widthAnchor constraintEqualToAnchor:self.imageView.heightAnchor],
                                               [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:kLeftRightPadding],
                                               [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor constant:kTopBottomPadding],
                                               [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                               [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor]]];
}

@end
