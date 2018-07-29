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
    self.titleLabel.font = [UIFont systemFontOfSize:kFontSizeHugeSemiheavy weight:UIFontWeightBold];
    self.imageView.image = [UIImage imageNamed:kMP3ItemImagePlaceholder];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.playButton];
    [NSLayoutConstraint activateConstraints: @[[self.imageView.heightAnchor constraintEqualToAnchor:self.widthAnchor multiplier:0.3],
                                               [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor],
                                               [self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                               [self.imageView.widthAnchor constraintEqualToAnchor:self.imageView.heightAnchor],
                                               [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:kLeftRightPadding],
                                               [self.titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
                                               [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                               [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor],
                                               [self.imageView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
                                               [self.playButton.widthAnchor constraintEqualToConstant:30.0],
                                               [self.playButton.heightAnchor constraintEqualToAnchor:self.playButton.widthAnchor],
                                               [self.playButton.bottomAnchor constraintEqualToAnchor:self.imageView.bottomAnchor constant:-5.0],
                                               [self.playButton.trailingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:-5.0]]];
    [self.titleLabel sizeToFit];
}

@end
