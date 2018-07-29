//
//  VSCollectionViewCell.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "VSCollectionViewCell.h"
#import "DataManager.h"
#import "DateFormatter.h"
#import "UIColor+CustomColors.h"

@implementation VSCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupViews];
    }
    return self;
}

#pragma mark - Lazy init properties

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kFontSizeHuge weight:UIFontWeightBold];
        _titleLabel.textColor = [UIColor darkGrayColorVS];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
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

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.layer.cornerRadius = 3.0;
        _imageView.clipsToBounds = YES;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}

- (UIButton *)downloadButton {
    if (!_downloadButton) {
        UIImage *image = [UIImage imageNamed:@"DownloadIcon"];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        _downloadButton = [[UIButton alloc] init];
        [_downloadButton setImage:image forState:UIControlStateNormal];
        _downloadButton.tintColor = [UIColor themeColor];
        _downloadButton.hidden = YES;
        _downloadButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _downloadButton;
}

- (UIView *)separatorView {
    if (!_separatorView) {
        _separatorView = [[UIView alloc] init];
        _separatorView.backgroundColor = UIColor.separatorColor;
        _separatorView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _separatorView;
}

#pragma mark - Methods

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    
    UIView *headerView = [[UIView alloc] init];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    [headerView addSubview:self.titleLabel];
    [headerView addSubview:self.imageView];
    [self addSubview:headerView];
    [self addSubview:self.separatorView];
    
    [NSLayoutConstraint activateConstraints: @[[headerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                               [headerView.topAnchor constraintEqualToAnchor:self.topAnchor constant:kTopBottomPadding],
                                               [headerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                               [headerView.heightAnchor constraintEqualToConstant:kMP3ImagePlaceholderHeight],
                                               [self.imageView.topAnchor constraintEqualToAnchor:headerView.topAnchor],
                                               [self.imageView.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor],
                                               [self.imageView.heightAnchor constraintEqualToConstant:kTEDImagePlaceholderHeight],
                                               [self.titleLabel.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor],
                                               [self.titleLabel.topAnchor constraintEqualToAnchor:headerView.topAnchor],
                                               [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.imageView.leadingAnchor constant:-10.0],
                                               [self.titleLabel.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor],
                                               ]];
    
    UIStackView *infoStackView = [[UIStackView alloc] init];
    infoStackView.axis = UILayoutConstraintAxisVertical;
    infoStackView.spacing = 3.0;
    [infoStackView addArrangedSubview:self.authorLabel];
    [infoStackView addArrangedSubview:self.pubDateAndDurationLabel];
    
    UIStackView *infoControlStackView = [[UIStackView alloc] init];
    infoControlStackView.axis = UILayoutConstraintAxisHorizontal;
    infoControlStackView.translatesAutoresizingMaskIntoConstraints = NO;
    infoControlStackView.distribution = UIStackViewDistributionFill;
    [infoControlStackView addArrangedSubview:infoStackView];
    [infoControlStackView addArrangedSubview:self.downloadButton];
    
    [self addSubview:infoControlStackView];
    [NSLayoutConstraint activateConstraints: @[[infoControlStackView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                               [infoControlStackView.topAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:10.0],
                                               [infoControlStackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                               [infoControlStackView.heightAnchor constraintGreaterThanOrEqualToConstant:30.0],
                                               [self.downloadButton.widthAnchor constraintEqualToConstant:25.0],
                                               [self.downloadButton.heightAnchor constraintEqualToConstant:18.0],
                                               [self.authorLabel.heightAnchor constraintGreaterThanOrEqualToConstant:kFontSizeRegular],
                                               [self.pubDateAndDurationLabel.heightAnchor constraintGreaterThanOrEqualToConstant:kFontSizeRegular],
                                               [self.separatorView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:kLeftRightPadding],
                                               [self.separatorView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-kLeftRightPadding],
                                               [self.separatorView.heightAnchor constraintEqualToConstant:1.0],
                                               [self.separatorView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant: -1.0]
                                               ]];
}

- (void)setValueForItem:(Item *)item {
    self.titleLabel.text = item.title;
    self.authorLabel.text = item.author;
    self.pubDateAndDurationLabel.text = [NSString stringWithFormat:@"%@  ᛫  %@", item.duration, [DateFormatter getStringFromDate:item.pubDate byFormat:@"dd MMM yyyy"]];
    self.downloadButton.hidden = item.persistentSourceType == kCoreData ? NO : YES;
    
    [DataManager getPreviewImageForItem:item completionBlock:^(UIImage *image) {
        self.imageView.image = image;
    }];
}

@end
