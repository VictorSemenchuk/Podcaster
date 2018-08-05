//
//  ContentViewController.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "Item.h"
#import "HeaderView.h"
#import "VideoDetailView.h"
#import "AudioHeaderView.h"

@protocol ContentViewControllerDelegate <NSObject>

- (void)persistentWasChanged;

@end

@interface ContentViewController : UIViewController

@property (weak, nonatomic) id<ContentViewControllerDelegate> delegate;

@property (nonatomic) Item *item;

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UILabel *authorLabel;
@property (nonatomic) UILabel *pubDateAndDurationLabel;
@property (nonatomic) UILabel *detailsLabel;
@property (nonatomic) UIButton *downloadButton;
@property (nonatomic) UIButton *removeButton;
@property (nonatomic) UIActivityIndicatorView *activityView;
@property (nonatomic) HeaderView *headerView;
@property (nonatomic) UIStackView *infoStackView;
@property (nonatomic) UIProgressView *progressView;
@property (nonatomic) UILabel *emptyContent;

- (void)fetchImage;
- (void)startPlaying;
- (void)downloadItem;
- (void)removeItem;

@end
