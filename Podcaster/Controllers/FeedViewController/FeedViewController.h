//
//  ViewController.h
//  Podcaster
//
//  Created by Viktar Semianchuk on 7/23/18.
//  Copyright © 2018 Viktar Semianchuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XMLParserService.h"
#import "Constants.h"
#import "SourceType.h"
#import "Item.h"
#import "DataManager.h"
#import "SettingsViewController.h"
#import "UIColor+CustomColors.h"
#import "MP3CollectionViewCell.h"
#import "TEDCollectionViewCell.h"

@interface FeedViewController : UIViewController

@property (nonatomic) NSArray *items;
@property (nonatomic) DataManager *dataManager;
@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UIActivityIndicatorView *activityIndicator;

- (void)presentSettingsViewController;

@end
