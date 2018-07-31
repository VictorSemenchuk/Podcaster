//
//  ContentViewController+Constraints.m
//  Podcaster
//
//  Created by Victor Macintosh on 26/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ContentViewController+Constraints.h"
#import "ContentViewController.h"

@implementation ContentViewController (Constraints)

- (void)setupViews {
    //scrollView
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
    self.scrollView.alwaysBounceVertical = YES;
    
    //contentView
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = UIColor.redColor;
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
    
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
    
    //detailsLabel
    self.detailsLabel = [[UILabel alloc] init];
    self.detailsLabel.font = [UIFont systemFontOfSize:kFontSizeHeavy weight:UIFontWeightRegular];
    self.detailsLabel.textColor = [UIColor darkTextColor];
    self.detailsLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.detailsLabel.numberOfLines = 0;
    
    //downloadButton
    self.downloadButton = [[UIButton alloc] init];
    [self.downloadButton setImage:[UIImage imageNamed:@"DownloadIcon"] forState:UIControlStateNormal];
    self.downloadButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.downloadButton addTarget:self action:@selector(downloadItem) forControlEvents:UIControlEventTouchUpInside];
    
    //removeButton
    self.removeButton = [[UIButton alloc] init];
    [self.removeButton setImage:[UIImage imageNamed:@"RemoveIcon"] forState:UIControlStateNormal];
    self.removeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.removeButton addTarget:self action:@selector(removeItem) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self setupConstraints];
}

- (void)setupConstraints {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    
    switch (self.item.sourceType) {
        case kMP3:
            self.headerView = [[AudioHeaderView alloc] init];
            break;
        case kTED:
            self.headerView = [[VideoDetailView alloc] init];
        default:
            break;
    }
    self.downloadButton.hidden = self.item.persistentSourceType == kCoreData ? YES : NO;
    self.removeButton.hidden = self.item.persistentSourceType == kRemote ? YES : NO;
    
    [self.scrollView addSubview:self.headerView];
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;

    self.infoStackView = [[UIStackView alloc] init];
    self.infoStackView.axis = UILayoutConstraintAxisVertical;
    self.infoStackView.spacing = 3.0;
    [self.infoStackView addArrangedSubview:self.authorLabel];
    [self.infoStackView addArrangedSubview:self.pubDateAndDurationLabel];
    
    UIStackView *infoControlStackView = [[UIStackView alloc] init];
    infoControlStackView.axis = UILayoutConstraintAxisHorizontal;
    infoControlStackView.translatesAutoresizingMaskIntoConstraints = NO;
    infoControlStackView.distribution = UIStackViewDistributionFill;
    [infoControlStackView addArrangedSubview:self.infoStackView];
    [infoControlStackView addArrangedSubview:self.downloadButton];
    [infoControlStackView addArrangedSubview:self.removeButton];
    
    [self.scrollView addSubview:infoControlStackView];
    [self.scrollView addSubview:self.detailsLabel];
    
    [NSLayoutConstraint activateConstraints:@[[self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              [self.headerView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
                                              [self.headerView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:20.0],
                                              [self.headerView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
                                              [self.headerView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
                                              [self.downloadButton.widthAnchor constraintEqualToConstant:27.0],
                                              [self.downloadButton.heightAnchor constraintEqualToConstant:24.0],
                                              [self.removeButton.widthAnchor constraintEqualToConstant:24.0],
                                              [self.removeButton.heightAnchor constraintEqualToConstant:24.0],
                                              [infoControlStackView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:kLeftRightPadding],
                                              [infoControlStackView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-kLeftRightPadding],
                                              [infoControlStackView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor constant:15.0],
                                              [infoControlStackView.heightAnchor constraintGreaterThanOrEqualToConstant:30.0],
                                              [self.detailsLabel.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:kLeftRightPadding],
                                              [self.detailsLabel.topAnchor constraintEqualToAnchor:infoControlStackView.bottomAnchor constant:15.0],
                                              [self.detailsLabel.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-kLeftRightPadding],
                                              [self.detailsLabel.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor constant:-20.0]]];
    [self.headerView setupViews];
}

@end
