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
    if (self.item) {
        //scrollView
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        self.scrollView.alwaysBounceVertical = YES;
        
        //progressView
        self.progressView = [[UIProgressView alloc] init];
        self.progressView.translatesAutoresizingMaskIntoConstraints = NO;
        self.progressView.hidden = YES;
        self.progressView.progressTintColor = [UIColor themeColor];
        
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
        
        //activityView
        self.activityView = [[UIActivityIndicatorView alloc] init];
        self.activityView.color = [UIColor themeColor];
        self.activityView.hidesWhenStopped = YES;
    } else {
        //emptyContent
        self.emptyContent = [[UILabel alloc] init];
        self.emptyContent.textColor = [UIColor grayColor];
        self.emptyContent.font = [UIFont systemFontOfSize:kFontSizeHugeHeavy weight:UIFontWeightSemibold];
        self.emptyContent.text = @"Select item";
        self.emptyContent.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    [self setupConstraints];
}

- (void)setupConstraints {
    if (self.item) {
        [self.view addSubview:self.scrollView];
        [self.scrollView addSubview:self.progressView];
        
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
        [infoControlStackView addArrangedSubview:self.activityView];
        
        [self.scrollView addSubview:infoControlStackView];
        [self.scrollView addSubview:self.detailsLabel];
        
        [NSLayoutConstraint activateConstraints:@[[self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                                  [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                                  [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                                  [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                                  [self.progressView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:kLeftRightPadding],
                                                  [self.progressView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-kLeftRightPadding],
                                                  [self.progressView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:kTopBottomPadding / 2.0],
                                                  [self.progressView.heightAnchor constraintEqualToConstant:1.0],
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
    } else {
        [self.view addSubview:self.emptyContent];
        [NSLayoutConstraint activateConstraints:@[[self.emptyContent.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                                  [self.emptyContent.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]]];
    }
}

@end
