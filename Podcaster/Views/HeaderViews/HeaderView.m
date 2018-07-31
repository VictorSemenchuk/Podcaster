//
//  HeaderView.m
//  Podcaster
//
//  Created by Victor Macintosh on 26/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

#pragma mark - Methods

- (void)setupViews {
    //titleLabel
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = [UIFont systemFontOfSize:kFontSizeHugeHeavy weight:UIFontWeightBold];
    self.titleLabel.textColor = [UIColor darkGrayColorVS];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel.numberOfLines = 0;
    
    //imageView
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.layer.cornerRadius = 3.0;
    self.imageView.clipsToBounds = YES;
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //playButton
    self.playButton = [[UIButton alloc] init];
    self.playButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.playButton setImage:[UIImage imageNamed:@"play-button"] forState:UIControlStateNormal];
    
    [self setupContraints];
}

- (void)setupContraints {}

@end
