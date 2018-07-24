//
//  MP3CollectionViewCell.h
//  Podcaster
//
//  Created by Victor Macintosh on 24/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"

@interface MP3CollectionViewCell : UICollectionViewCell

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *subtitleLabel;
@property (nonatomic) UIImageView *imageView;

- (void)setupViews;
- (void)setValueForItem:(Item *)item;

@end
