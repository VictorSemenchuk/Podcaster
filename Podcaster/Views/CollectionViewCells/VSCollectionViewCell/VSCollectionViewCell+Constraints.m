//
//  VSCollectionViewCell+Constraints.m
//  Podcaster
//
//  Created by Victor Macintosh on 31/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "VSCollectionViewCell+Constraints.h"

@implementation VSCollectionViewCell (Constraints)

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    
    //titleLabel
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:kFontSizeHuge weight:UIFontWeightBold];
    self.titleLabel.textColor = [UIColor darkGrayColorVS];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.numberOfLines = 0;
    
    //authorLabel
    self.authorLabel = [[UILabel alloc] init];
    self.authorLabel.font = [UIFont systemFontOfSize:kFontSizeRegular weight:UIFontWeightSemibold];
    self.authorLabel.textColor = [UIColor darkGrayColorVS];
    self.authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    //pubDateAndDurationLabel
    self.pubDateAndDurationLabel = [[UILabel alloc] init];
    self.pubDateAndDurationLabel.font = [UIFont systemFontOfSize:kFontSizeRegular weight:UIFontWeightRegular];
    self.pubDateAndDurationLabel.textColor = [UIColor lightGrayColorVS];
    self.pubDateAndDurationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    //imageView
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.cornerRadius = 3.0;
    self.imageView.clipsToBounds = YES;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //downloadButton
    UIImage *image = [UIImage imageNamed:@"DownloadedIcon"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.downloadButton = [[UIButton alloc] init];
    [self.downloadButton setImage:image forState:UIControlStateNormal];
    self.downloadButton.tintColor = [UIColor themeColor];
    self.downloadButton.hidden = YES;
    self.downloadButton.translatesAutoresizingMaskIntoConstraints = NO;
    
    //separatorView
    self.separatorView = [[UIView alloc] init];
    self.separatorView.backgroundColor = UIColor.separatorColor;
    self.separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self setupConstraints];
}

- (void)setupConstraints {
    UIView *headerView = [[UIView alloc] init];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:self.titleLabel];
    [headerView addSubview:self.imageView];
    [self addSubview:headerView];
    [self addSubview:self.separatorView];
    
    [NSLayoutConstraint activateConstraints: @[[headerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                               [headerView.topAnchor constraintEqualToAnchor:self.topAnchor constant:kTopBottomPadding],
                                               [headerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                               [headerView.heightAnchor constraintEqualToConstant:kMP3ImagePlaceholderHeight],
                                               [self.imageView.topAnchor constraintEqualToAnchor:headerView.topAnchor],
                                               [self.imageView.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor],
                                               [self.imageView.heightAnchor constraintEqualToConstant:kTEDImagePlaceholderHeight],
                                               [self.titleLabel.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor],
                                               [self.titleLabel.topAnchor constraintEqualToAnchor:headerView.topAnchor],
                                               [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.imageView.leadingAnchor constant:-10.0],
                                               [self.titleLabel.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor],
                                               ]];
    
//    UIStackView *infoStackView = [[UIStackView alloc] init];
//    infoStackView.axis = UILayoutConstraintAxisVertical;
//    infoStackView.spacing = 3.0;
//    [infoStackView addArrangedSubview:self.authorLabel];
//    [infoStackView addArrangedSubview:self.pubDateAndDurationLabel];
//
//    UIStackView *infoControlStackView = [[UIStackView alloc] init];
//    infoControlStackView.axis = UILayoutConstraintAxisHorizontal;
//    infoControlStackView.translatesAutoresizingMaskIntoConstraints = NO;
//    infoControlStackView.distribution = UIStackViewDistributionFill;
//    [infoControlStackView addArrangedSubview:infoStackView];
//    [infoControlStackView addArrangedSubview:self.downloadButton];
//
//    [self addSubview:infoControlStackView];
//    [NSLayoutConstraint activateConstraints: @[[infoControlStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
//                                               [infoControlStackView.topAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:10.0],
//                                               [infoControlStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
//                                               [infoControlStackView.heightAnchor constraintGreaterThanOrEqualToConstant:30.0],
//                                               [self.downloadButton.widthAnchor constraintEqualToConstant:25.0],
//                                               [self.downloadButton.heightAnchor constraintEqualToConstant:18.0],
//                                               [self.authorLabel.heightAnchor constraintGreaterThanOrEqualToConstant:kFontSizeRegular],
//                                               [self.pubDateAndDurationLabel.heightAnchor constraintGreaterThanOrEqualToConstant:kFontSizeRegular],
//                                               [self.separatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
//                                               [self.separatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
//                                               [self.separatorView.heightAnchor constraintEqualToConstant:1.0],
//                                               [self.separatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant: -1.0]
//                                               ]];
    
    UIView *infoView = [[UIView alloc] init];
    infoView.translatesAutoresizingMaskIntoConstraints = NO;
    [infoView addSubview:self.authorLabel];
    [infoView addSubview:self.pubDateAndDurationLabel];
    [self addSubview:infoView];
    [self addSubview:self.downloadButton];
    [NSLayoutConstraint activateConstraints:@[[infoView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                              [infoView.topAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:10.0],
                                              [infoView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                              [infoView.heightAnchor constraintEqualToConstant:30.0],
                                              [self.authorLabel.leadingAnchor constraintEqualToAnchor:infoView.leadingAnchor],
                                              [self.authorLabel.topAnchor constraintEqualToAnchor:infoView.topAnchor],
                                              [self.authorLabel.trailingAnchor constraintEqualToAnchor:self.downloadButton.leadingAnchor],
                                              [self.authorLabel.heightAnchor constraintEqualToConstant:kFontSizeRegular],
                                              [self.pubDateAndDurationLabel.leadingAnchor constraintEqualToAnchor:infoView.leadingAnchor],
                                              [self.pubDateAndDurationLabel.bottomAnchor constraintEqualToAnchor:infoView.bottomAnchor],
                                              [self.pubDateAndDurationLabel.trailingAnchor constraintEqualToAnchor:self.downloadButton.leadingAnchor],
                                              [self.pubDateAndDurationLabel.heightAnchor constraintEqualToConstant:kFontSizeRegular],
                                              [self.downloadButton.widthAnchor constraintEqualToConstant:25.0],
                                              [self.downloadButton.heightAnchor constraintEqualToConstant:18.0],
                                              [self.downloadButton.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                              [self.downloadButton.centerYAnchor constraintEqualToAnchor:infoView.centerYAnchor]
                                              ]];
}

@end
