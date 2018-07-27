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

@interface ContentViewController : UIViewController

@property (nonatomic) Item *item;

@property (nonatomic) UIScrollView *scrollView;
@property (nonatomic) UIView *contentView;
@property (nonatomic) UILabel *authorLabel;
@property (nonatomic) UILabel *pubDateAndDurationLabel;
@property (nonatomic) UITextView *detailsLabel;
@property (nonatomic) UIButton *downloadButton;
@property (nonatomic) HeaderView *headerView;
@property (nonatomic) UIStackView *infoStackView;

- (void)refreshContent;
- (void)downloadImage;

@end
