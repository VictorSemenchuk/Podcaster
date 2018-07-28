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
#import <AVKit/AVKit.h>

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
    [self.scrollView addSubview:self.headerView];
    self.headerView.titleLabel.text = self.item.title;
    self.headerView.translatesAutoresizingMaskIntoConstraints = NO;

    self.infoStackView = [[UIStackView alloc] init];
    self.infoStackView.axis = UILayoutConstraintAxisVertical;
    self.infoStackView.spacing = 3.0;
    self.infoStackView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.infoStackView addArrangedSubview:self.authorLabel];
    [self.infoStackView addArrangedSubview:self.pubDateAndDurationLabel];
    [self.scrollView addSubview:self.infoStackView];
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
                                              [self.downloadButton.bottomAnchor constraintEqualToAnchor:self.infoStackView.bottomAnchor],
                                              [self.infoStackView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:20.0],
                                              [self.infoStackView.trailingAnchor constraintEqualToAnchor:self.downloadButton.leadingAnchor constant:-20.0],
                                              [self.infoStackView.topAnchor constraintEqualToAnchor:self.headerView.bottomAnchor constant:15.0],
                                              [self.detailsLabel.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor constant:20.0],
                                              [self.detailsLabel.topAnchor constraintEqualToAnchor:self.infoStackView.bottomAnchor constant:15.0],
                                              [self.detailsLabel.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor constant:-20.0],
                                              [self.detailsLabel.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor constant:-20.0]]];
    
    [self.headerView setupViews];
    
//    if (self.item.sourceType == kTED) {
//        NSURL *url = [NSURL URLWithString:self.item.content.webUrl];
//        AVPlayer *player = [AVPlayer playerWithURL:url];
//        AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
//        [self presentViewController:controller animated:YES completion:nil];
//        controller.player = player;
//        [player play];
//    }
}

@end
