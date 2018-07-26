//
//  HeaderView.m
//  Podcaster
//
//  Created by Victor Macintosh on 26/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

#pragma mark - Lazy init properties

- (UITextView *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UITextView alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:kFontSizeHugeHeavy weight:UIFontWeightBold];
        _titleLabel.textColor = [UIColor darkGrayColorVS];
        _titleLabel.scrollEnabled = NO;
        _titleLabel.editable = NO;
        _titleLabel.textContainerInset = UIEdgeInsetsZero;
        _titleLabel.contentInset = UIEdgeInsetsMake(0.0, -5.0, 0.0, 0.0);
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
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

#pragma mark - Methods

- (void)setupViews {}

@end
