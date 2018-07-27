//
//  ContentViewController.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ContentViewController.h"
#import "UIColor+CustomColors.h"
#import "ContentViewController+Constraints.h"
#import "FileManager.h"
#import "DownloadManager.h"

@implementation ContentViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    [self setupViews];
    [self downloadImage];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = NO;
    } else {
        // Fallback on earlier versions
    }
}

#pragma mark - Lazy init properties

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        _scrollView.alwaysBounceVertical = YES;
    }
    return _scrollView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = UIColor.redColor;
        _contentView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _contentView;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont systemFontOfSize:kFontSizeRegular weight:UIFontWeightSemibold];
        _authorLabel.textColor = [UIColor darkGrayColorVS];
        _authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _authorLabel;
}

- (UILabel *)pubDateAndDurationLabel {
    if (!_pubDateAndDurationLabel) {
        _pubDateAndDurationLabel = [[UILabel alloc] init];
        _pubDateAndDurationLabel.font = [UIFont systemFontOfSize:kFontSizeRegular weight:UIFontWeightRegular];
        _pubDateAndDurationLabel.textColor = [UIColor lightGrayColorVS];
        _pubDateAndDurationLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _pubDateAndDurationLabel;
}

- (UITextView *)detailsLabel {
    if (!_detailsLabel) {
        _detailsLabel = [[UITextView alloc] init];
        _detailsLabel.font = [UIFont systemFontOfSize:kFontSizeRegular weight:UIFontWeightRegular];
        _detailsLabel.textColor = [UIColor darkGrayColorVS];
        _detailsLabel.scrollEnabled = NO;
        _detailsLabel.editable = NO;
        _detailsLabel.selectable = NO;
        _detailsLabel.textContainerInset = UIEdgeInsetsZero;
        _detailsLabel.contentInset = UIEdgeInsetsMake(0.0, -5.0, 0.0, 0.0);
        _detailsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
        style.lineSpacing = 5.0;
        _detailsLabel.attributedText = [[NSAttributedString alloc]
                                   initWithString:@"Predefined Text"
                                   attributes:@{NSParagraphStyleAttributeName : style}];
    }
    return _detailsLabel;
}

- (UIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [[UIButton alloc] init];
        [_downloadButton setImage:[UIImage imageNamed:@"DownloadIcon"] forState:UIControlStateNormal];
        _downloadButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _downloadButton;
}

- (void)refreshContent {
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    [self setupViews];
}

- (void)downloadImage {
    DownloadManager *downloadManager = [[DownloadManager alloc] init];
    [downloadManager downloadFileForURL:self.item.image.webUrl withCompletionBlock:^(NSData *data) {
        self.headerView.imageView.image = [UIImage imageWithData:data];
    }];
}

@end
