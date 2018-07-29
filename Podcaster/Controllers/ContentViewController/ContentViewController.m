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
#import "DownloadManager.h"
#import "FileManager.h"
#import "ItemCoreDataService.h"
#import "DataManager.h"
#import <AVKit/AVKit.h>

@implementation ContentViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.navigationController.navigationBar.tintColor = UIColor.themeColor;
    if (self.item) {
        [self setupViews];
        [self fetchImage];
        [self.headerView.playButton addTarget:self action:@selector(startPlaying) forControlEvents:UIControlEventTouchUpInside];
    }
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

- (UILabel *)detailsLabel {
    if (!_detailsLabel) {
        _detailsLabel = [[UILabel alloc] init];
        _detailsLabel.font = [UIFont systemFontOfSize:kFontSizeHeavy weight:UIFontWeightRegular];
        _detailsLabel.textColor = [UIColor darkTextColor];
        _detailsLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _detailsLabel.numberOfLines = 0;
    }
    return _detailsLabel;
}

- (UIButton *)downloadButton {
    if (!_downloadButton) {
        _downloadButton = [[UIButton alloc] init];
        [_downloadButton setImage:[UIImage imageNamed:@"DownloadIcon"] forState:UIControlStateNormal];
        _downloadButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_downloadButton addTarget:self action:@selector(changePersistentState) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

#pragma mark - Methods

- (void)fetchImage {
    if ([self.item.image.localFullUrl isEqualToString:@""]) {
        [DownloadManager downloadFileForURL:self.item.image.webUrl withCompletionBlock:^(NSData *data) {
            self.headerView.imageView.image = [UIImage imageWithData:data];
        }];
    } else {
        FileManager *fileManager = [FileManager sharedFileManager];
        self.headerView.imageView.image = [fileManager getImageFromPath:self.item.image.localFullUrl withSandboxFolderType:kDocuments];
    }
}

#pragma mark - Target methods

- (void)startPlaying {
    NSURL *url;
    if (![self.item.content.localUrl isEqualToString:@""]) {
        NSString *path = [[FileManager sharedFileManager] getPathForUrl:self.item.content.localUrl withSandboxFolderType:kDocuments];
        NSLog(@"%@", path);
        url = [NSURL URLWithString:path];
    } else {
         url = [NSURL URLWithString:self.item.content.webUrl];
    }
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    controller.player = player;
    [player play];
}

- (void)changePersistentState {
    if (self.item.persistentSourceType == kCoreData) {
        [DataManager removeItemFromPersistent:self.item completionBlock:^{
            [self.delegate persistentWasChanged];
        }];
    } else {
        DataManager *dataManager = [[DataManager alloc] init];
        [dataManager saveItemToPersistent:self.item completionBlock:^{
            [self.delegate persistentWasChanged];
        }];
    }
}

@end
