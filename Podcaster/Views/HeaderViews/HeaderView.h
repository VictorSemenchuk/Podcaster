//
//  HeaderView.h
//  Podcaster
//
//  Created by Victor Macintosh on 26/07/2018.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UIColor+CustomColors.h"

@interface HeaderView : UIView

@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *titleLabel;
@property (nonatomic) UIButton *playButton;

- (void)setupViews;

@end
