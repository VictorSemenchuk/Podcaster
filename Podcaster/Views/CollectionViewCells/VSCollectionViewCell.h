//
//  VSCollectionViewCell.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/25/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "Constants.h"
#import "UIColor+CustomColors.h"

@interface VSCollectionViewCell : UICollectionViewCell

@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UILabel *authorLabel;
@property (nonatomic) UILabel *pubDateAndDurationLabel;
@property (nonatomic) UIImageView *imageView;

- (void)setupViews;
- (void)setValueForItem:(Item *)item;


@end
