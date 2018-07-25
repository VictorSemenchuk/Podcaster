//
//  MP3CollectionViewCell.m
//  Podcaster
//
//  Created by Victor Macintosh on 24/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MP3CollectionViewCell.h"
#import "Constants.h"
#import "UIColor+CustomColors.h"

@implementation MP3CollectionViewCell

#pragma mark - Methods

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    self.imageView.image = [UIImage imageNamed:kMP3ItemImagePlaceholder];
    
    UIView *contentView = [[UIView alloc] init];
    contentView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:contentView];
    
    UIStackView *mainStackView = [[UIStackView alloc] init];
    mainStackView.axis = UILayoutConstraintAxisVertical;
    mainStackView.spacing = 5.0;
    mainStackView.translatesAutoresizingMaskIntoConstraints = NO;

    UIStackView *infoStackView = [[UIStackView alloc] init];
    infoStackView.axis = UILayoutConstraintAxisVertical;
    infoStackView.spacing = 2.0;

    [contentView addSubview:self.imageView];
    [contentView addSubview:mainStackView];
    [mainStackView addArrangedSubview:self.titleLabel];
    [mainStackView addArrangedSubview:infoStackView];
    [infoStackView addArrangedSubview:self.authorLabel];
    [infoStackView addArrangedSubview:self.pubDateAndDurationLabel];

    [NSLayoutConstraint activateConstraints:@[[contentView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kCollectionViewLeftRightPadding],
                                              [contentView.topAnchor constraintEqualToAnchor:self.topAnchor constant:kCollectionViewTopBottomPadding],
                                              [contentView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kCollectionViewLeftRightPadding],
                                              [contentView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-kCollectionViewTopBottomPadding],
                                              [self.imageView.leadingAnchor constraintEqualToAnchor:contentView.leadingAnchor],
                                              [self.imageView.topAnchor constraintEqualToAnchor:contentView.topAnchor],
                                              [self.imageView.widthAnchor constraintEqualToConstant:kMP3ImagePlaceholderWidth],
                                              [self.imageView.heightAnchor constraintEqualToConstant:kMP3ImagePlaceholderHeight],
                                              [mainStackView.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:kCollectionViewLeftRightPadding],
                                              [mainStackView.topAnchor constraintEqualToAnchor:contentView.topAnchor constant: 2.0],
                                              [mainStackView.trailingAnchor constraintEqualToAnchor:contentView.trailingAnchor],
                                              ]];
}


@end