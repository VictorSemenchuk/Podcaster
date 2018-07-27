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
    //////---TEMP DATA---///////
    self.item = [[Item alloc] init];
    self.item.sourceType = kTED;
    self.authorLabel.text = @"Victor Semenchuk";
    self.pubDateAndDurationLabel.text = @"26.07 | 0:05";
    self.detailsLabel.text = @"Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia, looked up one of the more obscure Latin words, consectetur, from a Lorem Ipsum passage, and going through the cites of the word in classical literature, discovered the undoubtable source. Lorem Ipsum comes from sections 1.10.32 and 1.10.33 of  (The Extremes of Good and Evil) by Cicero, written in 45 BC. This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, comes from a line in section 1.10.32.";
    
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
    [self.scrollView addSubview:self.headerView];
    self.headerView.titleLabel.text = @"Title 1";
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;

    UIStackView *infoStackView = [[UIStackView alloc] init];
    infoStackView.axis = UILayoutConstraintAxisVertical;
    infoStackView.spacing = 3.0;
    infoStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [infoStackView addArrangedSubview:self.authorLabel];
    [infoStackView addArrangedSubview:self.pubDateAndDurationLabel];
    [self.scrollView addSubview:infoStackView];
    [self.scrollView addSubview:self.downloadButton];
    [self.scrollView addSubview:self.detailsLabel];
    
    [NSLayoutConstraint activateConstraints:@[[self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                              [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                              [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                              [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                                              [self.headerView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
                                              [self.headerView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor constant:20.0],
                                              [self.headerView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
                                              [self.headerView.widthAnchor constraintEqualToAnchor:self.view.widthAnchor],
                                              [self.downloadButton.widthAnchor constraintEqualToConstant:25.0],
                                              [self.downloadButton.heightAnchor constraintEqualToConstant:18.0],
                                              [self.downloadButton.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-20.0],
                                              [self.downloadButton.bottomAnchor constraintEqualToAnchor:infoStackView.bottomAnchor],
                                              [infoStackView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:20.0],
                                              [infoStackView.trailingAnchor constraintEqualToAnchor:self.downloadButton.leadingAnchor constant:-20.0],
                                              [infoStackView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor constant:15.0],
                                              [self.detailsLabel.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:20.0],
                                              [self.detailsLabel.topAnchor constraintEqualToAnchor:infoStackView.bottomAnchor constant:15.0],
                                              [self.detailsLabel.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-20.0],
                                              [self.detailsLabel.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor constant:-20.0]]];
    [self.headerView setupViews];
}

@end
