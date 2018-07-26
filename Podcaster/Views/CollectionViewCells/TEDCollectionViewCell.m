//
//  TEDCollectionViewCell.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "TEDCollectionViewCell.h"

@implementation TEDCollectionViewCell

#pragma mark - Methods

- (void)setupViews {

    self.backgroundColor = UIColor.whiteColor;
    self.imageView.image = [UIImage imageNamed:kTEDItemImagePlaceholder];
    
    UIView *headerView = [[UIView alloc] init];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:self.titleLabel];
    [headerView addSubview:self.imageView];
    [self addSubview:headerView];
    
    [NSLayoutConstraint activateConstraints: @[[headerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kCollectionViewLeftRightPadding],
                                               [headerView.topAnchor constraintEqualToAnchor:self.topAnchor constant:kCollectionViewTopBottomPadding],
                                               [headerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kCollectionViewLeftRightPadding],
                                               [headerView.heightAnchor constraintEqualToConstant:kMP3ImagePlaceholderHeight],
                                               [self.imageView.topAnchor constraintEqualToAnchor:headerView.topAnchor],
                                               [self.imageView.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor],
                                               [self.imageView.widthAnchor constraintEqualToConstant:kTEDImagePlaceholderWidth],
                                               [self.imageView.heightAnchor constraintEqualToConstant:kTEDImagePlaceholderHeight],
                                               [self.titleLabel.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor],
                                               [self.titleLabel.topAnchor constraintEqualToAnchor:headerView.topAnchor],
                                               [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.imageView.leadingAnchor constant:-10.0],
                                               [self.titleLabel.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor],
                                               ]];
    
    UIStackView *infoStackView = [[UIStackView alloc] init];
    infoStackView.axis = UILayoutConstraintAxisVertical;
    infoStackView.spacing = 3.0;
    infoStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [infoStackView addArrangedSubview:self.authorLabel];
    [infoStackView addArrangedSubview:self.pubDateAndDurationLabel];
    [self addSubview:infoStackView];
    [self addSubview:self.downloadButton];
    
    [NSLayoutConstraint activateConstraints: @[[infoStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kCollectionViewLeftRightPadding],
                                               [infoStackView.topAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:10.0],
                                               [self.downloadButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kCollectionViewLeftRightPadding],
                                               [self.downloadButton.widthAnchor constraintEqualToConstant:25.0],
                                               [self.downloadButton.heightAnchor constraintEqualToConstant:18.0],
                                               [self.downloadButton.bottomAnchor constraintEqualToAnchor:infoStackView.bottomAnchor],
                                               [infoStackView.trailingAnchor constraintEqualToAnchor:self.downloadButton.leadingAnchor constant:-kCollectionViewLeftRightPadding],
                                               ]];
    
}

@end
