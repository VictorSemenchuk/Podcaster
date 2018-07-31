//
//  MP3CollectionViewCell.m
//  Podcaster
//
//  Created by Victor Macintosh on 24/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import "MP3CollectionViewCell.h"
#import "Constants.h"
#import "UIColor+CustomColors.h"
#import "FileManager.h"
#import "VSCollectionViewCell+Constraints.h"

@implementation MP3CollectionViewCell

#pragma mark - Methods

- (void)setupViews {
    [super setupViews];
    self.imageView.image = [UIImage imageNamed:kMP3ItemImagePlaceholder];
    [NSLayoutConstraint activateConstraints:@[[self.imageView.widthAnchor constraintEqualToConstant:kMP3ImagePlaceholderWidth]]];
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.imageView.image = [UIImage imageNamed:kMP3ItemImagePlaceholder];
}

@end
