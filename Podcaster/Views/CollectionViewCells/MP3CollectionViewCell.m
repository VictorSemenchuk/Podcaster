//
//  MP3CollectionViewCell.m
//  Podcaster
//
//  Created by Victor Macintosh on 24/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MP3CollectionViewCell.h"

@implementation MP3CollectionViewCell

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
        _titleLabel.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
        _titleLabel.textColor = [UIColor colorWithRed:48.0/255.0 green:48.0/255.0 blue:60.0/255.0 alpha:255.0/255.0];
        _titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel {
    if (!_subtitleLabel) {
        _subtitleLabel = [[UILabel alloc] init];
        _subtitleLabel.font = [UIFont systemFontOfSize:12.0 weight:UIFontWeightRegular];
        _subtitleLabel.textColor = [UIColor colorWithRed:149.0/255.0 green:155.0/255.0 blue:165.0/255.0 alpha:255.0/255.0];
        _subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _subtitleLabel;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MP3ItemImagePlaceholder"]];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _imageView;
}

#pragma mark - Methods

- (void)setupViews {
    self.backgroundColor = UIColor.whiteColor;
    self.layer.cornerRadius = 3.0;
    self.clipsToBounds = YES;
    
    UIStackView *stackView = [[UIStackView alloc] init];
    stackView.axis = UILayoutConstraintAxisVertical;
    stackView.spacing = 5.0;
    stackView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.imageView];
    [self addSubview:stackView];
    [stackView addArrangedSubview:self.titleLabel];
    [stackView addArrangedSubview:self.subtitleLabel];
    
    [NSLayoutConstraint activateConstraints:@[[self.imageView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:10.0],
                                              [self.imageView.topAnchor constraintEqualToAnchor:self.topAnchor constant:10.0],
                                              [self.imageView.widthAnchor constraintEqualToConstant:60.0],
                                              [self.imageView.heightAnchor constraintEqualToConstant:60.0],
                                              [stackView.leadingAnchor constraintEqualToAnchor:self.imageView.trailingAnchor constant:10.0],
                                              [stackView.topAnchor constraintEqualToAnchor:self.topAnchor constant:12.0],
                                              [stackView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-10.0],
                                              ]];
}

- (void)setValueForItem:(Item *)item {
    self.titleLabel.text = item.title;
    self.subtitleLabel.text = item.duration;
}

@end
