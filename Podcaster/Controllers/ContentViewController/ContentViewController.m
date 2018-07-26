//
//  ContentViewController.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/24/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

- (void)setupViews;

@end

@implementation ContentViewController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    [self setupViews];
}

#pragma mark - Lazy init properties

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = UIColor.greenColor;
        _scrollView.translatesAutoresizingMaskIntoConstraints = NO;
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

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kFontSizeHugeHeavy weight:UIFontWeightBold];
        _titleLabel.textColor = [UIColor darkTextColor];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

#pragma mark - Methods

- (void)setupViews {
    
    //scrollView
    [self.view addSubview:self.scrollView];
    [NSLayoutConstraint activateConstraints: @[[self.scrollView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                                               [self.scrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
                                               [self.scrollView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
                                               [self.scrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
                                               ]];
    
    //contentView
    [self.scrollView addSubview:self.contentView];
    NSLayoutConstraint *contentViewHeightConstraint = [self.contentView.heightAnchor constraintEqualToAnchor:self.scrollView.heightAnchor];
    contentViewHeightConstraint.priority = 250;
    [NSLayoutConstraint activateConstraints: @[[self.contentView.leadingAnchor constraintEqualToAnchor:self.scrollView.leadingAnchor],
                                               [self.contentView.topAnchor constraintEqualToAnchor:self.scrollView.topAnchor],
                                               [self.contentView.trailingAnchor constraintEqualToAnchor:self.scrollView.trailingAnchor],
                                               [self.contentView.bottomAnchor constraintEqualToAnchor:self.scrollView.bottomAnchor],
                                               [self.contentView.widthAnchor constraintEqualToAnchor:self.scrollView.widthAnchor],
                                               contentViewHeightConstraint
                                               ]];
    
    [self.contentView addSubview:self.titleLabel];
    [NSLayoutConstraint activateConstraints: @[[self.titleLabel.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:kCollectionViewLeftRightPadding],
                                               [self.titleLabel.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:40.0],
                                               [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-kCollectionViewLeftRightPadding],
                                               [self.titleLabel.heightAnchor constraintEqualToConstant:kFontSizeHuge]]];
    self.titleLabel.text = @"Hello world!";
    
}

@end
