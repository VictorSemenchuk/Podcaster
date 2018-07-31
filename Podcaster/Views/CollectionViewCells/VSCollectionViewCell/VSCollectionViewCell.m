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
#import "VSCollectionViewCell+Constraints.h"

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

#pragma mark - Methods

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
