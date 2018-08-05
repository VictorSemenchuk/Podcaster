//
//  ContentViewController.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ContentViewController.h"
#import "UIColor+CustomColors.h"
#import "UIImage+Getting.h"
#import "ContentViewController+Constraints.h"
#import "DownloadManager.h"
#import "FileManager.h"
#import "ItemCoreDataService.h"
#import "NSString+Format.h"
#import <AVKit/AVKit.h>
#import "DataManager+Removing.h"
#import "DataManager+Saving.h"
#import "ContentViewController+DataManagerSavingDelegate.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    self.navigationController.navigationBar.tintColor = UIColor.themeColor;
    [self setupViews];
    if (self.item) {
        [self setValues];
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

#pragma mark - Methods

- (void)fetchImage {
    if ([self.item.image.localFullUrl isEqualToString:@""]) {
        [DownloadManager downloadFileForURL:self.item.image.webUrl withCompletionBlock:^(NSData *data) {
            self.headerView.imageView.image = [UIImage imageWithData:data];
        }];
    } else {
        self.headerView.imageView.image = [UIImage getImageFromPath:self.item.image.localFullUrl withSandboxFolderType:kDocuments];
    }
}

- (void)setValues {
    self.authorLabel.text = self.item.author;
     self.pubDateAndDurationLabel.text = [NSString stringWithFormat:@"%@  ᛫  %@", self.item.duration, [NSString stringWithFormat:@"dd MMM yyyy" fromDate:self.item.pubDate]];
    self.detailsLabel.text = self.item.details;
    self.headerView.titleLabel.text = self.item.title;
    [self fetchImage];
}

#pragma mark - Target methods

- (void)startPlaying {
    NSURL *url;
    if (![self.item.content.localUrl isEqualToString:@""]) {
        NSString *path = [[FileManager sharedFileManager] getPathForUrl:self.item.content.localUrl withSandboxFolderType:kDocuments];
        NSLog(@"%@", path);
        url = [NSURL fileURLWithPath:path];
    } else {
         url = [NSURL URLWithString:self.item.content.webUrl];
    }
    AVPlayer *player = [AVPlayer playerWithURL:url];
    AVPlayerViewController *controller = [[AVPlayerViewController alloc] init];
    [self presentViewController:controller animated:YES completion:nil];
    controller.player = player;
    [player play];
}

- (void)downloadItem {
    DataManager *dataManager = [[DataManager alloc] init];
    dataManager.savingDelegate = self;
    [dataManager saveItemToPersistent:self.item completionBlock:^{
        [self.delegate persistentWasChanged];
        self.downloadButton.hidden = YES;
    }];
}

- (void)removeItem {
    [DataManager removeItemFromPersistent:self.item completionBlock:^{
        [self.delegate persistentWasChanged];
        self.downloadButton.hidden = NO;
        self.removeButton.hidden = YES;
    }];
}

@end
