//
//  ContentViewController+Constraints.m
//  Podcaster
//
//  Created by Victor Macintosh on 26/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ContentViewController+Constraints.h"
#import "ContentViewController.h"
#import "DateFormatter.h"

@implementation ContentViewController (Constraints)

- (void)setupViews {
    self.authorLabel.text = self.item.author;
    self.pubDateAndDurationLabel.text = [NSString stringWithFormat:@"%@  ᛫  %@", self.item.duration, [DateFormatter getStringFromDate:self.item.pubDate byFormat:@"dd MMM yyyy"]];
    self.detailsLabel.text = self.item.details;
    
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
    self.headerView.titleLabel.text = self.item.title;
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
