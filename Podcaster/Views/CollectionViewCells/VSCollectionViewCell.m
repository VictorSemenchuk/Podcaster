//
//  VSCollectionViewCell.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "VSCollectionViewCell.h"

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

- (UITextView *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UITextView alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kFontSizeHuge weight:UIFontWeightBold];
        _titleLabel.textColor = [UIColor darkGrayColorVS];
        _titleLabel.scrollEnabled = NO;
        _titleLabel.editable = NO;
        _titleLabel.textContainerInset = UIEdgeInsetsZero;
        _titleLabel.contentInset = UIEdgeInsetsMake(0.0, -5.0, 0.0, 0.0);
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UILabel *)authorLabel {
    if (!_authorLabel) {
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.font = [UIFont systemFontOfSize:kFontSizeSmall weight:UIFontWeightSemibold];
        _authorLabel.textColor = [UIColor darkGrayColorVS];
        _authorLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _authorLabel;
}

- (UILabel *)pubDateAndDurationLabel {
    if (!_pubDateAndDurationLabel) {
        _pubDateAndDurationLabel = [[UILabel alloc] init];
        _pubDateAndDurationLabel.font = [UIFont systemFontOfSize:kFontSizeSmall weight:UIFontWeightRegular];
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
        _downloadButton = [[UIButton alloc] init];
        [_downloadButton setImage:[UIImage imageNamed:@"DownloadIcon"] forState:UIControlStateNormal];
        _downloadButton.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _downloadButton;
}

#pragma mark - Methods

- (void)setupViews {
}

- (void)setValueForItem:(Item *)item {
    self.titleLabel.text = item.title;
    self.authorLabel.text = item.author;
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMM yyyy"];
    self.pubDateAndDurationLabel.text = [NSString stringWithFormat:@"%@ ᛫ %@", item.duration, [dateFormat stringFromDate:item.pubDate]];
}

@end
