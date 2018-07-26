//
//  TEDCollectionViewCell.m
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "TEDCollectionViewCell.h"

@implementation TEDCollectionViewCell

#pragma mark - Methods

- (void)setupViews {
    [super setupViews];
    self.imageView.image = [UIImage imageNamed:kTEDItemImagePlaceholder];
    [NSLayoutConstraint activateConstraints:@[[self.imageView.widthAnchor constraintEqualToConstant:kTEDImagePlaceholderWidth]]];
}

@end
